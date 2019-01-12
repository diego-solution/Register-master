require "uri"
# frozen_string_literal: true

# Export the event into calendar format
class CalendarService
  def initialize(params)
    @event     = params[:event]
    @client    = ENV["ADD_EVENT_CLIENT"]
  end

  # Accepts: apple or google or outlook or outlookcom or yahoo or stream.
  def share_url(service = "apple")
    #start_time, end_time = ""
    #Time.use_zone(@event.time_zone) do
    start_time = @event.event_start_date.utc.iso8601
    end_time   = @event.event_end_date.utc.iso8601
    #end
    parameters = { client: @client,
                   start: start_time,
                   end: end_time,
                   title: @event.public_name,
                   location: @event.location,
                   #  timezone: @event.time_zone,
                   timezone: "UTC",
                   service: service,
                   reference: @event.url,
                   description: @event.description }
    URI::HTTPS.build(host: "www.addevent.com", path: "/dir", query: parameters.to_query).to_s
  end
end
