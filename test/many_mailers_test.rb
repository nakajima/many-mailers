require 'abstract_unit'

class ManyMailersTest < Test::Unit::TestCase
  
  def setup
    ActionMailer::Base.default_server = :default
    ActionMailer::Base.load_settings!(File.dirname(__FILE__) + '/mail_servers.yml')
  end
  
  def test_should_load_settings_properly
    settings = ActionMailer::Base.mail_servers[:default]
    assert_equal 'mail.example.com', settings[:address]
    assert_equal 25, settings[:port]
    assert_equal 'example.com', settings[:domain]
    assert_equal 'test_user', settings[:user_name]
    assert_equal 'test_password', settings[:password]
    
    settings = ActionMailer::Base.mail_servers[:internal]
    assert_equal 'internal.example.com', settings[:address]
    assert_equal 'internal_test_user', settings[:user_name]
    assert_equal 'internal_test_password', settings[:password]
  end
  
  def test_should_default_to_default
    assert_equal ActionMailer::Base.mail_servers[:default], ActionMailer::Base.smtp_settings
  end
  
  def test_should_allow_custom_default_server
    UserMailer.default_server = :internal
    assert_equal ActionMailer::Base.mail_servers[:internal], UserMailer.smtp_settings
  end
  
  def test_should_allow_temporary_custom_server
    assert_equal ActionMailer::Base.mail_servers[:default], UserMailer.smtp_settings
    UserMailer.with_settings(:internal) do |mailer|
      assert_equal ActionMailer::Base.mail_servers[:internal], UserMailer.smtp_settings
    end
    assert_equal ActionMailer::Base.mail_servers[:default], UserMailer.smtp_settings
  end

end