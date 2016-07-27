require 'rails_helper'

def nation_api_token_attributes(overrides = {})
  {
    nation_slug: 'nbevents',
    api_token: ENV["TESTING_TOKEN"],
    note: 'This is only a test.',
    user_id: 1,
    site_slug: 'nbevents'
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    email: 'kyle.sponheim@gmail.com'
  }.merge(overrides)
end

def event_attributes(overrides = {})
  {
    site_slug: 'nbevents',
    id: 1,
    event: {
      name: 'test',
      page_slug: 'test',
      headline: 'this is only a test',
      title: 'testing purposes only',
      excerpt: 'hey social media!',
      status: 'unlisted',
      start_time: Date.parse('2016-07-29'),
      end_time: Date.parse('2016-07-30')
    }
  }.merge(overrides)
end
