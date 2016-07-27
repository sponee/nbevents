require 'rails_helper'

    def login_user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
      end
    end

describe WelcomeController do

  context "When not logged in" do

    it "displays a log in url" do
      visit root_url

      click_link 'Log In'

      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "When logged in" do
    login_user

    it "displays a log out url" do
      visit root_url

      click_link 'Logout'

      expect(current_path).to eq(destroy_user_session_path)
    end
  end
end