class SignupsController < ApplicationController
  before_action :authenticate_user!, :set_client
  
  def index
    if params["page"].to_i == 2 
      @signups = @client.call(:people, :index)
      @paginated_signups = NationBuilder::Paginator.new(@client, @signups)
      @signups = @paginated_signups.next.body
    elsif params["page"].to_i > 2
      @signups = @client.call(:people, :index)
      params["page"].to_i.times do |i|
        @paginated_signups = NationBuilder::Paginator.new(@client, @signups)
        @signups = @paginated_signups.next.body
      end
      @signups
    else
      @signups = @client.call(:people, :index)
    end
  end

  def show
    @signup = @client.call(:people, :show, id: params["signup_id"])
  end

  private

  def set_user
    @user = current_user
  end

  def set_client
    set_user
    @client = NationBuilder::Client.new(params["nation_slug"], params["token"])
  end
end