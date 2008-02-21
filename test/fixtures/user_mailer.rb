class UserMailer < ActionMailer::Base
  def feedback(message)
    from       'Service <service@example.com>'
    recipients 'Feedback <feedback@example.com>'
    subject    "Feedback"
    body        :message => message
  end  
end

