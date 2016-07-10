class WelcomeController < ApplicationController

  def index
    set_user
  end

  def create_rsvp
    set_client
    @client.call(:events, :rsvp_create, site_slug: 'trainerkyle', id: 4, rsvp: {person_id: params["person_id"]})
    redirect_to action: "index"
  end

  private

  def set_user
    @user = current_user
  end

  def set_client
    set_user
    @client = NationBuilder::Client.new(@user.nation_api_tokens.first.nation_slug, @user.nation_api_tokens.first.api_token)
  end

end

#@client.call(:events, :show, site_slug: 'trainerkyle', id: 4)
#@client.call(:events, :rsvp_create, site_slug: 'trainerkyle', id: 4, rsvp: {person_id: 5722})

#Below is an example of how to make an API call using NationApiTokens.

#set_client
#@events = @client.call(:events, :show, site_slug: @user.nation_api_tokens.first.nation_slug, id: 4)

#<%= form_tag html: { multipart: true } do |f| %>
#  <ul style="list-style-type:none">
#    <li><%= label_tag(:person_id, "Person ID") %></li>
#    <li><%= text_field_tag(:person_id, "Person ID") %></li>
#    <li><%= label_tag(:guests_count, "Guests Count") %></li>
#    <li><%= text_field_tag(:guests_count,"Guests Count") %></li>
#    <li><%= label_tag(:volunteer, "Volunteering?") %></li>
#    <li><%= check_box_tag(:volunteer) %></li>
#    <li><%= label_tag(:private, "Keep secret?") %></li>
#    <li><%= check_box_tag(:private) %></li>
#    <%= submit_tag "Submit RSVP" %>
#  </ul>
#<% end %>