class AddSiteSlugToNationApiTokens < ActiveRecord::Migration
  def change
    add_column :nation_api_tokens, :site_slug, :string
  end
end
