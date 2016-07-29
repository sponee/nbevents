require 'rails_helper'

def nation_api_token_attributes(overrides = {})
  {
    nation_slug: ENV["TESTING_SLUG"],
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
    site_slug: ENV["TESTING_SLUG"],
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

def signup_attributes(overrides = {})
  {
    id: 3,
    person: {
      first_name: "Kyle", 
      last_name: "Sponheim",
      email: "mytestemail@example.com",
      employer: "N/A",
      occupation: "Engineer",
      is_volunteer: "true",
      email_opt_in: "false",
      phone: "3233335544",
      mobile: "3235554476",
      work_phone_number: "9512367725",
      note: "Hi there!",
      sex: "M",
      support_level: "1",
      twitter_name: "handleit",
      availability: "weekends",
      ethnicity: "spaghetti",
      facebook_profile_url: "facebook.com",
      website: "website.com"
    }
  }.merge(overrides)
end
