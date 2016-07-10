class CreateNationApiTokens < ActiveRecord::Migration
  def change
    create_table :nation_api_tokens do |t|
      t.string :nation_slug
      t.string :api_token
      t.text :note

      t.timestamps null: false
    end
  end
end
