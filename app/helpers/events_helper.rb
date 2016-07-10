module EventsHelper

  def show_events(events)
    if events["results"].class == Hash
      'This is a hash of events.'
    elsif events["results"].class == Array
      events["results"].each do |e|
        'This is an array of events.'
      end
    else
      content_tag(:strong, "fuck all this noise.")
    end
  end

end
