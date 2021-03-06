if ENV.key?("APP_USERNAME") && ENV.key?("APP_PASSWORD")
  Vowessly::Application.config.middleware.insert_after 'Rack::Lock', 'Rack::Auth::Basic' do |username, password|
    (username == ENV["APP_USERNAME"] && password == ENV["APP_PASSWORD"]) ||
    (username == ENV["APP_SUPERVISOR_USERNAME"] && password == ENV["APP_SUPERVISOR_PASSWORD"])
  end
end
