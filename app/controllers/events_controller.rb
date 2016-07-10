class EventsController < ApplicationController
  before_action :authenticate_user!, :set_client

  def show
    @client.call(:events, :show, site_slug: params["site_slug"], id: params["id"])
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
      site_slug: params["nation_slug"],
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

  private

  def set_user
    @user = current_user
  end

  def set_client
    set_user
    @client = NationBuilder::Client.new(params["nation_slug"], params["token"])
  end
  
end