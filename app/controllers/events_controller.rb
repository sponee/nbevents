class EventsController < ApplicationController
  before_action :authenticate_user!, :set_client, :require_permission

  def show
   @event = @client.call(:events, :show, site_slug: params["site_slug"], id: params["id"])
  end

  def rsvp_form
   @event = @client.call(:events, :show, site_slug: params["site_slug"], id: params["id"])
  end

  def submit_rsvp
    @response = @client.call(:people, :push, person: { email: params["email"] })
    if @response["status_code"] == 200
      @response = @client.call(:events, :rsvp_create, site_slug: params["site_slug"], id: params["id"], rsvp: {person_id: @response["person"]["id"]})
      if @response["status_code"] == 200
        redirect_to :back, notice: "RSVP submitted!"
      end
    else
      render :submit_rsvp, notice: "Something went wrong."
    end
  end

  def index
    @events = @client.call(:events, :index, site_slug: params["site_slug"])
  end

  def edit
    @event = @client.call(:events, :show, site_slug: params["site_slug"], id: params["id"])
  end

  def update
    @update = @client.call(:events, :update, site_slug: params["site_slug"], id: params["id"], event: { 
      name: params["name"], 
      slug: params["slug"], 
      status: params["status"],
      headline: params["headline"], 
      title: params["title"], 
      excerpt: params["excerpt"], 
      intro: params["intro"], 
      capacity: params["capacity"], 
      start_time: params["start_time"], 
      end_time: params["end_time"] 
      })
    if @update["status_code"] == 200
      redirect_to :back, notice: "Event successfully updated!"
    else
      render :edit
    end
  end

  def create
    @update = @client.call(:events, :create, 
      site_slug: params["site_slug"],
      id: params["id"],
      event: {
        status: params["status"],
        name: params["name"],
        slug: params["slug"],
        headline: params["headline"],
        title: params["title"],
        excerpt: params["excerpt"],
        intro: params["intro"],
        capacity: params["capacity"],
        start_time: params["start_time"],
        end_time: params["end_time"]
      })
    if @update["status_code"] == 200
      redirect_to user_nation_api_tokens_path(@user), notice: "Event successfully created!"
    else
      render :new
    end
  end

  def destroy
    @response = @client.call(:events, :destroy, site_slug: params["site_slug"], id: params["id"])
    if @response == true
      redirect_to user_nation_api_tokens_path(@user), alert: "Event successfully deleted!"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_client
    set_user
    @client = NationBuilder::Client.new(params["nation_slug"], params["token"])
  end

  def require_permission
    if current_user != User.find(params["user_id"])
      redirect_to root_path, alert: "You are not authorized to view this content."
    end
  end
  
end