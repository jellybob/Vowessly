$heroku = ENV['USER'] ? !! ENV['USER'].match(/^repo\d+/) : ENV.any? { |key, _| key.match(/^HEROKU_/) }

source 'http://rubygems.org'
gem 'rails', '3.0.3'

gem 'activo-rails', :git => 'git://github.com/jellybob/activo-rails.git'
gem 'bson_ext', '1.1.2'
gem 'mongoid', '2.0.0.beta.20'
gem 'mongoid_slug', :require => "mongoid/slug"

unless $heroku
  group :test, :development do
    gem "autotest"
    gem "capybara"
    gem 'cucumber-rails'
    gem 'cucumber'
    gem 'database_cleaner'
    gem 'factory_girl_rails'
    gem 'launchy'
    gem "rspec-rails", "~> 2.0.1"
    gem "ruby-debug19"
    gem 'thin'
  end
end
