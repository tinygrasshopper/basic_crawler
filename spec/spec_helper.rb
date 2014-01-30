require 'simplecov'
SimpleCov.start

require_relative '../lib/basic_crawler'

require 'webmock/rspec'
WebMock.disable_net_connect!


RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true
end