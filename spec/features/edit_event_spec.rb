require 'rails_helper'
require 'nationbuilder'

describe EventsController do
  before(:each) do
    login
    create_nation_api_token
  end

  describe "update" do

    it "updates and saves the event and redirects to the NationApiTokens Index URL" do 

      slug = 'nbevents'
      token = ENV["TESTING_TOKEN"]
      client = NationBuilder::Client.new(slug, token)
      event = event_attributes
      client.call(:events, :create, event)      
      response = client.call(:events, :update, event)

      expect(response["status_code"]).to eq(200)
    end
  end
end