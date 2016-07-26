require 'rails_helper'

describe "Viewing the top nav" do

  context "When not logged in" do

    it "displays a log in url" do
      visit root_url

      click_link 'Log In'

      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "When logged in" do
    let(:current_user) { User.new(user_attributes) }

    it "displays a log out url" 
      
  end
end