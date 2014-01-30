require 'rubygems'
require 'bundler'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'link'
require_relative 'input_counter'
require_relative 'crawler'
require_relative 'link_queue'
require_relative 'crawler_manager'
require_relative 'crawler_cli'
