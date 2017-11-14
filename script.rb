require 'gmail'
require 'net/https'
require 'time'
require 'api-auth'
require 'json'

def http_post(url, params, options={})
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true 
  body = params.to_json

  request = Net::HTTP::Post.new(uri.request_uri)
  request.body = body
  request['Content-Type'] = 'application/json'
  request['Content-Length'] = body.bytesize

  ApiAuth.sign!(request, options[:access_key_id], options[:access_secret_key])

  response = http.request(request)
  card = response.body
  
  card 
end

gmail = Gmail.connect("<email_address>", "<your_password>")
emails = gmail.inbox.find(:unread, :from => '<desired_email_address>')
URL = 'https://<instance_name>.mingle-api.thoughtworks.com/api/v2/projects/<project_identifier>/cards.xml'
OPTIONS = {:access_key_id => '<access_key>', :access_secret_key => '<secret_access_key>'}

emails.each do |email|
	PARAMS = { 
	  :card => { 
	    :type => "<card_type>", :name => email.subject, :description => email.body.raw_source
	    }
	  }

	http_post(URL, PARAMS, OPTIONS)

	email.read! 
end
