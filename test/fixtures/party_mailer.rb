class PartyMailer < ActionMailer::Base
  def invitation(message)
    from       'Invitations <invitations@example.com>'
    recipients 'Recipient <recipient@example.com>'
    subject    "You're invited!"
    body       :message => message
  end  
end

