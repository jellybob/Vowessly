# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
[ "support/**/*.rb", "factories/*.rb" ].each do |path|
  Dir[Rails.root.join(path)].each {|f| require f}
end

RSpec.configure do |config|
  config.include Mongoid::Matchers
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) { DatabaseCleaner.start } 
  config.after(:each) { DatabaseCleaner.clean }
end
