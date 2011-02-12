# Use Syck for YAML parsing - Psych doesn't do inheritance
require 'yaml'
YAML::ENGINE.yamler = 'syck'

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Vowessly::Application.initialize!
