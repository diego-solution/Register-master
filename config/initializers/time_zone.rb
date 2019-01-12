# Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
# Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
I18n.available_locales = [:en]
Rails.application.config.time_zone = "UTC"
# turn off warnings triggered by friendly_id
#I18n.enforce_available_locales = false

# Set default locale to something other than :en
I18n.default_locale = :en
