require 'rails_helper'

describe EventsController do
  before(:each) do
    login
    create_nation_api_token
  end

  describe "create" do

    it "creates and saves the event and redirects to the NationApiTokens Index URL" do 

      event = event_attributes
      create_client
      response = @client.call(:events, :create, event)

      expect(response["status_code"]).to eq(200)
      expect(current_path).to eq(root_path)
    end
  end
end