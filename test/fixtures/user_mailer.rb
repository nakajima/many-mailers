class UserMailer < ActionMailer::Base
  self.template_root = "#{RAILS_ROOT}/views"

  def feedback(message)
    from       'Service <service@example.com>'
    recipients 'Feedback <feedback@example.com>'
    subject    "Feedback"
    body        :message => message
  end  
end

