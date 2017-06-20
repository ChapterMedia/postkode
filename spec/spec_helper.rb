require 'simplecov'
SimpleCov.start
require_relative '../lib/postkode'

RSpec.configure do |config|
  config.example_status_persistence_file_path = "tmp/examples_results.txt"
end
