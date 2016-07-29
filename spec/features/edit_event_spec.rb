require 'rails_helper'
require 'nationbuilder'

describe EventsController do
  before(:each) do
    login
    create_nation_api_token
    create_client
  end

  describe "update" do

    it "updates and saves the event" do 

      event = event_attributes  
      response = @client.call(:events, :update, event)

      expect(response["status_code"]).to eq(200)
    end
  end
end