ENV['RAILS_ENV'] ||= 'test'
require File.dirname(__FILE__) + '/../../../../config/environment.rb'
require 'fixtures/user_mailer'
require 'test/unit'