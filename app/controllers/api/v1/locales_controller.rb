# frozen_string_literal: true

# returns locales and other i18n related information
class Api::V1::LocalesController < ApiController
  include ActiveSupport

  # GET /timezones
  def time_zones
    render_success(get_formatted_timezones.as_json)
  end

  # GET /country_names
  def countries
    render_success(get_countries.as_json)
  end

  private

  def get_formatted_timezones
    Rails.cache.fetch("time_zones_list", expires_in: 48.hours) do
      TimeZone.all.map { |tz|
        {
          label: "(GMT " + TimeZone.seconds_to_utc_offset(tz.utc_offset) + ") " + tz.name,
          value: tz.tzinfo.name
        }
      }
    end
  end

  def get_countries
    Rails.cache.fetch("country_names", expires_in: 48.hours) do
      ISO3166::Country.all_names_with_codes.map { |c| { label: c[0], value: c[1] } }
    end
  end
end
