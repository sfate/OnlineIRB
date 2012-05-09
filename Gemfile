source 'https://rubygems.org'
source 'http://gems.github.com'

# app core
gem 'sinatra'
gem 'sinatra-reloader'

# use json for data exchange
gem 'json'

# server
gem 'thin'

# use messaging
gem 'tmm1-amqp', :require => 'mq'
gem 'eventmachine'
gem 'minion', :git => "git@github.com:Sfate/minion.git"

# heroku addition
group :production do
  gem 'pg'
end

