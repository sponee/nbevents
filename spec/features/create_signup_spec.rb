require 'rails_helper'

describe SignupsController do
  before(:each) do
    login
    create_nation_api_token
  end

  describe "create" do

    it "presents first and last name, email, employer, and gender fields." do
      visit new_user_signup_path(@user, token: ENV["TESTING_TOKEN"], nation_slug: ENV["TESTING_SLUG"])
      
      expect(page).to have_text("First Name")
      expect(page).to have_text("Last Name")
      expect(page).to have_text("Email")
      expect(page).to have_text("Employer")
      expect(page).to have_text("Gender")
    end

    it "creates and saves the signup" do 

      signup = signup_attributes
      create_client
      response = @client.call(:people, :push, signup)      

      expect(response["person"]["id"]).to eq(3)
    end
  end
end