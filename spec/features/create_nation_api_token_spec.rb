require 'rails_helper'

describe NationApiTokensController do
  before(:each) do
    login
  end
  describe "create" do

    it "creates and saves the token and redirects to the new token" do 

      visit new_user_nation_api_tokens_url(@user)

      fill_in "Nation slug", with: "slug"
      fill_in "Site slug", with: "site slug"
      fill_in "Api token", with: "This is a test token"

      click_button "Submit"

      expect(page).to have_text("API Token successfully created!")
    end

    it "does not save the token if it's invalid" do
      visit new_user_nation_api_tokens_url(@user)
      
      click_button "Submit"
      
      expect(page).to have_text("The nationapitoken could not be saved. Please correct the following")
    end
  end
end