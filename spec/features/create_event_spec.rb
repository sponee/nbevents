require 'rails_helper'

describe EventsController do
  before(:each) do
    login
    create_nation_api_token
  end

  describe "create" do

    it "creates and saves the event and redirects to the NationApiTokens Index URL" do 

      visit new_user_event_url(@user)

      expect(page).to have_text("Name")
    end
  end
end