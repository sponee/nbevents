require 'rails_helper'

def event_attributes(overrides = {})
  {
    nation_slug: 'nbevents',
    api_token: '6f6eb7232ed40eec17adc7b10407110b5c071b030a85a6db1c97352e3920f8a0',
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