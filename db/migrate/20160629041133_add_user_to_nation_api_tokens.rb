class AddUserToNationApiTokens < ActiveRecord::Migration
  def change
    add_reference :nation_api_tokens, :user, index: true, foreign_key: true
  end
end
