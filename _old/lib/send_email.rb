require 'net/smtp'

def ts_send_email(from_name,from,reply_to_name,reply_to,to_name,to,subject,message_body)
  message = <<MESSAGE_END
From: #{from_name} <#{from}>
Reply-To: #{reply_to_name} {#{reply_to}>
To: #{to_name} <#{to}>
Subject: #{subject}

#{message_body}
MESSAGE_END
  
  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message message, from, to
  end
end

#ts_send_email('Awesome Admin','no-reply@awesome.techstud.io','Ryan Burnette','ryan.burnette@gmail.com','Ryan Burnete','ryan.burnette@gmail.com','Test','This is a test.')