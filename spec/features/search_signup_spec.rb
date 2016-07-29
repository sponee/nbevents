require 'rails_helper'
require 'nationbuilder'

describe SignupsController do
  before(:each) do
    login
    create_nation_api_token
  end

  describe "search_form" do

    it "provides a form to collect email and redirects to a signup if found." do 

      visit(user_signup_search_path(@user))

      expect(page).to have_text("Email")
      expect(page).to have_button("Search")
    end
  end

  describe "search_results" do

    it "calls the api and redirets to the signup if found." do

      visit(user_signup_search_path(@user, token: ENV["TESTING_TOKEN"], nation_slug: ENV["TESTING_SLUG"]))
      fill_in "Email", with: "help@nationbuilder.com"

      click_button "Search"

      expect(page).to have_text("Signup Identified!")
    end
  end
end