require 'rails_helper'

describe NationApiTokensController do
  before(:each) do
    login
    create_nation_api_token
    create_client
  end

  describe "update" do

    it "updates and saves the token and redirects to show the token" do 

      visit edit_user_nation_api_tokens_path(@user, token_id: @user.nation_api_tokens.first)

      fill_in "Site slug", with: "newsiteslug"

      click_button "Update"

      expect(page).to have_text("token successfully updated!")
      expect(current_path).to eq(show_token_path(@user, id: @user.nation_api_tokens.first))
    end

    it "does not save the token if it's invalid" do
      visit new_user_nation_api_tokens_url(@user, token_id: @user.nation_api_tokens.first)
      
      click_button "Submit"

      fill_in "Site slug", with: ""
      
      expect(page).to have_text("The nationapitoken could not be saved. Please correct the following")
    end
  end
end