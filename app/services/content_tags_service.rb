# frozen_string_literal: true

# Build special content to be sent out as codified strings
# For now, this is a simple class. As we create more objects, consider applying certain patterns, such as an Abstract Factory
class ContentTagsService
  def initialize(params)
    @event = params[:event]
    @tags = []
    init_tags
  end

  # replate text with tags
  def replace_tags(text)
    Time.use_zone(@event.time_zone) do
      new_text = text.dup
      if new_text.present?
        tags.each do |tag|
          find    = tag[:find]
          replace = tag[:replace]
          verify  = tag[:verify]
          default = tag[:default]

          begin
            #should we verify that the method exists in the object? or just go for it?
            replace = if event.instance_eval(verify)
                        event.instance_eval(replace)
                      else
                        default
                      end
          rescue StandardError
            replace = default
          end

          new_text.gsub!(find, replace)
        end
        new_text
      else
        ""
      end
    end
  end

  # return an array with the available tags and description
  def available_tags
    preview = []
    tags.each do |tag|
      preview << { tag: tag[:find], description: tag[:description] }
    end
    preview
  end

  private

  attr_reader :event, :tags

  def init_tags
    tags << {
      find: "{{event.name}}",
      verify: "public_name",
      replace: "public_name",
      default: "",
      description: "The public name of event"
    }

    tags << {
      find: "{{event.team_name}}",
      verify: "team_name",
      replace: "team_name",
      default: "",
      description: "The team name for the company doing the event"
    }

    tags << {
      find: "{{event.time_zone}}",
      verify: "time_zone",
      replace: "time_zone",
      default: "",
      description: "The time_zone for the event"
    }

    tags << {
      find: "{{event.location}}",
      verify: "location",
      replace: "location",
      default: "",
      description: "The public name of event"
    }

    tags << {
      find: "{{event.description}}",
      verify: "description",
      replace: "description",
      default: "",
      description: "The event description"
    }

    tags << {
      find: "{{event.city}}",
      verify: "city",
      replace: "city",
      default: "",
      description: "The city of event"
    }

    tags << {
      find: "{{event.registration_start_date}}",
      verify: "registration_start_date",
      replace: "registration_start_date.to_s(:year_month_day_no_time)",
      default: "",
      description: "The date that registration opens"
    }

    tags << {
      find: "{{event.registration_close_date}}",
      verify: "registration_close_date",
      replace: "registration_close_date.to_s(:year_month_day_no_time)",
      default: "",
      description: "The Close Date for registering new attendees"
    }

    tags << {
      find: "{{event.start_date}}",
      verify: "event_start_date",
      replace: "event_start_date.to_s(:year_month_day_no_time)",
      default: "",
      description: "The Start Date for the event"
    }

    tags << {
      find: "{{event.end_date}}",
      verify: "event_end_date",
      replace: "event_end_date.to_s(:year_month_day_no_time)",
      default: "",
      description: "The End Date for the event"
    }

    tags << {
      find: "{{event.start_time}}",
      verify: "event_start_date",
      replace: "event_start_date.to_s(:time_short)",
      default: "",
      description: "The Start Time for the event"
    }

    tags << {
      find: "{{event.end_time}}",
      verify: "event_end_date",
      replace: "event_end_date.to_s(:time_short)",
      default: "",
      description: "The End Time for the event"
    }
  end
end
