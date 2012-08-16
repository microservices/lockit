require 'rubygems'
require 'bundler/setup'

if ENV['COVERAGE'] and RUBY_VERSION =~ /^1.9/
  require 'simplecov'
  SimpleCov.start
end

require 'rspec'
require 'lockit'

RSpec.configure do |config|

end
