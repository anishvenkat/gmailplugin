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

gmail = Gmail.connect("<email username>", "<email password>")
emails = gmail.inbox.find(:unread, :from => 'do-not-reply@thoughtworks.com')
URL = 'https://sarahh.mingle-api.thoughtworks.com/api/v2/projects/test_project/cards.xml'
OPTIONS = {:access_key_id => '<access key>', :access_secret_key => '<secret key>'}

emails.each do |email|
	PARAMS = { 
	  :card => { 
	    :type => "Feedback", :name => email.subject, :description => email.body
	    }
	  }

	http_post(URL, PARAMS, OPTIONS)

	email.read! 
end
