# frozen_string_literal: true

source "https://rubygems.org"
ruby "2.4.4" # update in .ruby-version too

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# ENV variables
gem "dotenv-rails", "~> 2.5"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.2"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"
# Use PG json attribute for translations
gem "json_translate"
# Use Passenger as the app server
gem "passenger", "~> 5.1"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# use SLIM for views
gem "slim-rails"

# frontend
gem "webpacker", "~> 3.5.3"

# Use CoffeeScript for .coffee assets and views
#gem "coffee-rails", "~> 4.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem "jbuilder", "~> 2.5"
# Forms
#gem "simple_form"

gem "kaminari"
# Country selection
gem "country_select"
# Order stuff
gem "acts_as_list"
# encrypt files and fields
gem "attr_encrypted", "~> 3.1.0"

# for inline css in emails
gem "premailer-rails"

# Run several apps at once
gem "foreman"

# Endpoint performance
gem "skylight", "~> 2.0.2"

# Use JWT to decode and encode Tokens for api auth
gem "jwt", "~> 2.1.0"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 3.0"

# Use devise for managing users
gem "devise", "~> 4.5"
# additional security
gem "devise-authy"
gem "devise-security"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1"
# Define roles
gem "rolify", "~> 5.2"
# Authorisation gem
gem "cancancan", "~> 2.1"
# State machine
gem "aasm", "~> 4.12"
# Audit Changes
gem 'paper_trail'
gem 'paper_trail-association_tracking'

#ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem "active_model_serializers", "~> 0.10.7"

# Automatically respond to JSON::API requests
gem "json_api_responders", "~> 2.5.0"

gem 'activeadmin', '~> 1.3.0'

# XLSStream output
gem "xlsxtream", "~> 2.1"

# Background jobs
gem "que", "~> 0.14.2"
gem "que-web", "~> 0.6"
# Repeating jobs
gem "crono"

# user tracking and chat
gem "intercom", "~> 3.5"
gem "intercom-rails", "~> 0.3"

# error reporting
gem "airbrake", "~> 5.0"

# security helpers
gem "secure_headers", "~> 3.6.4"

# stop attacks on api
gem "rack-attack"
# setup cors
gem "rack-cors"

# image manipulation and uploading
gem "mini_magick", "~> 4.9"

# uploading images/files
gem "carrierwave", "~> 1.2.3"
gem "carrierwave-aws", "~> 1.3.0"
gem "carrierwave-virus_free", "~> 0.1.0"

# Sending emails using Mandrill
gem "mandrill_mailer", "~> 0.2.1"

group :development, :test do
  gem "puma"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "rspec-rails"
end

group :test do
  gem "capybara", "~> 2.13"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "parallel_tests"
  gem "phantomjs", require: "phantomjs/poltergeist"
  gem "poltergeist"
end

group :development do
  # better error pages
  gem "better_errors"

  gem 'brakeman', require: false

  gem "binding_of_caller"
  # Use Capistrano for deployment
  gem "capistrano-rails"
  # manage crono jobs on deployment
  gem "capistrano-crono"
  # other capistrano gems
  gem "capistrano-bundler"
  gem "capistrano-nvm", require: false
  gem "capistrano-passenger"
  gem "capistrano-rvm"
  # annotate models
  gem "annotate"
  gem 'listen', '~> 3.1.5'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  # gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "rubocop", "0.60.0"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  # garbage collector tuning
  gem "tunemygc"
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
