require 'rails_helper'

def login
  User.destroy_all
  visit new_user_session_url

  @user = FactoryGirl.create(:user)

  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password

  click_button "Log in"
end

def create_nation_api_token
  login
  @token = @user.nation_api_tokens.create(nation_api_token_attributes)
end