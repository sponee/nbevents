class AddSiteIdToNationApiToken < ActiveRecord::Migration
  def change
    add_column :nation_api_tokens, :site_id, :integer
  end
end
