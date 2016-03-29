class EmailSend < ApplicationMailer
  def welcome(user, sub)
     attachments['.jpg'] = File.read("#{Rails.root}/public/email11.jpg")
     mail(:to => user.email, :from => "batch250@store.in", :subject => sub)
  end
  def pay_c
    
  end
end
