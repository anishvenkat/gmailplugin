Purpose of the script: 

The goal of this tool is to parse your Gmail emails and for each, create a card within a mingle project with the content of the email in the body of the new Mingle card.

Prerequisites: 

Below are the tech stack they will require on the system to run the script:

Git (Download url: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
Ruby version 2.3.1 (Download url : https://www.ruby-lang.org/en/documentation/installation/)

Install below gems on the system:

gem install mail
gem install gmail
gem install api-auth -v 1.0.3
gem install activesupport


Implementation: 

Step 1: Clone the repository on the system

Run command "git clone https://github.com/anishvenkat/gmailplugin.git" from the console.

Step 2: Navigate to /path/where/the/git/repository/is/clone/gmailplugin

Step 3: Open and update below details in the script.rb file 

Gmail configuration:

gmail = Gmail.connect("<email_address_of_inbox>", "<your_password>")
emails = gmail.inbox.find(:unread, :from => '<desired_email_address>')

Mingle details:

URL = 'https://<your_instance_name>.mingle-api.thoughtworks.com/api/v2/projects/<project_name>/cards.xml'
OPTIONS = {:access_key_id => '<access key>', :access_secret_key => '<secret key>'}

Step 4: Run "ruby script.rb" command to run the script.
