require 'gmail'

def open_gmail_connection
	@gmail = Gmail.connect("<gmail username>", "<gmail password>")
	p @gmail.inbox.count
end

def close_gmail_connection
	@gmail.logout
	p "hi, I am no longer connected"
end

open_gmail_connection
close_gmail_connection