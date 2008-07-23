require 'abstract_unit'

class ManyMailersTest < Test::Unit::TestCase
  
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
    assert_equal ActionMailer::Base.mail_servers[:default], UserMailer.smtp_settings
  end
  
  def test_should_allow_temporary_custom_server
    UserMailer.with_settings(:internal) do |mailer|
      assert_equal ActionMailer::Base.mail_servers[:internal], UserMailer.smtp_settings
    end
    assert_equal ActionMailer::Base.mail_servers[:default], UserMailer.smtp_settings
  end
  
  def test_should_only_change_settings_for_one_class
    UserMailer.with_settings(:internal) do |mailer|
      assert_equal ActionMailer::Base.mail_servers[:internal], UserMailer.smtp_settings
      assert_equal ActionMailer::Base.mail_servers[:default], PartyMailer.smtp_settings, "Changed settings globally!"
    end
  end
  
  def test_should_retry_with_failovers
    UserMailer.with_settings(:internal, :retry => :default) do |mailer|
      begin; mailer.deliver_feedback('Oh, thanks.')
      rescue; assert_equal ActionMailer::Base.mail_servers[:default], UserMailer.smtp_settings end
    end
  end

end