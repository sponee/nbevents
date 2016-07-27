require 'rails_helper'

def login
  visit new_user_session_url

  user = FactoryGirl.create(:user)

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password

  click_button "Log in"
end