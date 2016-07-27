require 'rails_helper'

describe "The top nav" do
  context "when not logged in" do 

    it "displays a log in link" do
      visit root_url
      click_link 'Log In'

      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "when logged in" do 
    before(:each) do
      login
    end

    it "displays a logout link" do
      expect(page).to have_link('Logout')
    end
    
    it "displays 'My API Tokens' as a link" do
      expect(page).to have_link('My API Tokens')
    end

    it "displays 'New API Token' as a link" do
      expect(page).to have_link('New API Token')
    end
  end
end
