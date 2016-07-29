class SignupsController < ApplicationController
  before_action :authenticate_user!, :set_client, :require_permission
  
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
    @signup = @client.call(:people, :show, id: params["id"])
    #
  end

  def edit
    @signup = @client.call(:people, :show, id: params["id"])
  end

  def update
    @update = @client.call(:people, :update, id: params["id"], person: { 
      first_name: params["first_name"], 
      last_name: params["last_name"],
      email: params["email"],
      employer: params["employer"]
      })
    if @update["status_code"] == 200
      redirect_to :back, notice: "Signup successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @response = @client.call(:people, :destroy, id: params["id"])
    if @response == true
      redirect_to user_signups_path, alert: "API Token successfully deleted!"
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
      redirect_to root_path, notice: "You are not authorized to view this content."
    end
  end
end