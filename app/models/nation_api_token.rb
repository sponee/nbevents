class NationApiToken < ActiveRecord::Base

  belongs_to :user
  
  validates :nation_slug, :site_slug, presence: true
  validates :api_token, presence: true, uniqueness: true
end