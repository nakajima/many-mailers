ENV['RAILS_ENV'] ||= 'test'
begin
  require File.dirname(__FILE__) + '/../../../../config/environment.rb'
rescue LoadError
  RAILS_ROOT = File.dirname(__FILE__) + '/fixtures'
  require 'rubygems'
  require 'action_mailer'
  require File.dirname(__FILE__) + '/../lib/many_mailers.rb'
end
require File.join(File.dirname(__FILE__), 'fixtures/user_mailer')
require File.join(File.dirname(__FILE__), 'fixtures/party_mailer')
require 'test/unit'