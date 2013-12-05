require 'net/smtp'

message = <<MESSAGE_END
From: Awesome Admin <ryan.burnette@gmail.com>
To: Ryan Burnette <ryan.burnette@gmail.com>
Subject: SMTP email test

This is a test email message.
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'ryan.burnette@gmail.com'
end
