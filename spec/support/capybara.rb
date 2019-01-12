# frozen_string_literal: true

Capybara.asset_host = "http://localhost:3000"
#Capybara::Screenshot.autosave_on_failure = false
#Capybara::Screenshot.prune_strategy = :keep_last_run

# Capybara.register_server :puma do |app, port, host|
#   require 'puma'
#   Puma::Server.new(app).tap do |s|
#     s.add_tcp_listener host, port
#   end.run.join
# end
#Capybara.server = :puma
Capybara.server = :puma, { Silent: true } # To clean up your test output
#Capybara.javascript_driver = :poltergeist
Capybara.register_driver(:poltergeist) do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs_options: ["--load-images=false", "--ignore-ssl-errors=yes"])
end
Capybara.javascript_driver = :poltergeist
