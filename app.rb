require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'capybara'
require File.join(File.dirname(__FILE__), 'tweet')

class App < Sinatra::Base
  register Sinatra::Reloader

  not_found do
    erb :"404.html"
  end

  get '/about' do
    "Simple app that provides you access to ruby console"
  end

  get '/' do
    erb :"index.html"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

