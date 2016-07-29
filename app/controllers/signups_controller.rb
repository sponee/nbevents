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

  def new
  end

  def search_form
  end

  def search_results
    @response = @client.call(:people, :match, email: params["email"])
    if @response["person"]
      redirect_to user_signup_path(id: @response["person"]["id"], nation_slug: params["nation_slug"], token: params["token"]), notice: "Signup Identified!"
    else
      render :search, alert: "Could not find a signup with that email."
    end
  end

  def show
    @signup = @client.call(:people, :show, id: params["id"])
  end

  def create
    @response = @client.call(:people, :create, person: { 
      first_name: params["first_name"],
      last_name: params["last_name"],
      email: params["email"]
      })
    if @response["person"]
      redirect_to user_signup_path(id: @response["person"]["id"], nation_slug: params["nation_slug"], token: params["token"]), notice: "Signup successfully created!"
    else
      render :new, alert: "Something went wrong."
    end
  end

  def edit
    @signup = @client.call(:people, :show, id: params["id"])
  end

  def update
    @update = @client.call(:people, :update, id: params["id"], person: { 
      first_name: params["first_name"], 
      last_name: params["last_name"],
      email: params["email"],
      employer: params["employer"],
      occupation: params["occupation"],
      is_volunteer: params["is_volunteer"],
      email_opt_in: params["email_opt_in"],
      phone: params["phone"],
      mobile: params["mobile"],
      work_phone_number: params["work_phone_number"],
      note: params["note"],
      sex: params["sex"],
      support_level: params["support_level"],
      twitter_name: params["twitter_name"],
      availability: params["availability"],
      ethnicity: params["ethnicity"],
      facebook_profile_url: params["facebook_profile_url"],
      website: params["website"]
      })
    if @update["status_code"] == 200
      redirect_to user_signup_path(id: params["id"], nation_slug: params["nation_slug"], token: params["token"]), notice: "Signup successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @response = @client.call(:people, :destroy, id: params["id"])
    if @response == true
      redirect_to user_signups_path(nation_slug: params["nation_slug"], token: params["token"]), notice: "Signup successfully deleted!"
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