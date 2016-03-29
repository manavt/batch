# Preview all emails at http://localhost:3000/rails/mailers/email_send
class EmailSendPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/email_send/welcome
  def welcome
    EmailSend.welcome
  end

end
