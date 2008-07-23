ENV['RAILS_ENV'] ||= 'test'
begin
  require File.dirname(__FILE__) + '/../../../../config/environment.rb'
rescue LoadError
  RAILS_ROOT = File.dirname(__FILE__) + '/fixtures'
  require 'rubygems'
  require 'action_mailer'
  require File.dirname(__FILE__) + '/../lib/many_mailers.rb'
end
require 'fixtures/user_mailer'
require 'fixtures/party_mailer'
require 'test/unit'
require 'mocha'