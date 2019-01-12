# frozen_string_literal: true

class Rack::Attack
  # your custom configuration...

  #Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  #Here’s a simple setup which will allow an IP address to make 10 requests every 10 seconds.
  # throttle('req/ip', limit: 10, period: 10) do |req|
  #   req.ip
  # end
  # self.throttled_response = ->(env) {
  #   retry_after = (env['rack.attack.match_data'] || {})[:period]
  #   [
  #     429,
  #     {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
  #     [{meta:{code: "Too Many Requests" , message: "Throttle limit reached. Retry later."}}.to_json]
  #   ]
  # }

  # Throttle POST requests to /users/sign_in by IP address
  #
  # throttle('/users/sign_in by ip', limit: 5, period: 20.seconds) do |req|
  #   if req.path == '/users/sign_in' && req.post?
  #     req.ip
  #   end
  # end

  Rack::Attack.blocklist("block xmlrpc.php") do |req|
    req.path == "/xmlrpc.php" #&& req.post? && req.user_agent == 'BadUA'
  end

  Rack::Attack.blocklist("block wp admin") do |req|
    req.path == "/wp-admin" || req.path == "/wp-login"
  end
end
