require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'rest-client'
require 'minion'
include Minion
require './models'

class App < Sinatra::Base
  register Sinatra::Reloader
  enable :sessions
  set :session_secret, '3d83e096577fe350553f97f2d1b71579'

  not_found do
    erb :"404.html"
  end

  get 'about' do
    "Simple app that provides you access to ruby console"
  end

  get '/' do
    @ruby_v = RUBY_VERSION#.match(/1.[8-9].[0-9]p\d{3}/).to_s rescue "ruby"
    erb :"index.html"
  end

  post 'process' do
    session[:current_id] = rand(36**12).to_s(36)
    eval_data = EvalData.new(:id => session[:current_id])
    Minion.enqueue("evaluate_send",
      {:code_block => params[:code_block].strip, :id => eval_data.id} )
  end

  post 'update' do
    return "Can't proceed values mistyped" if params[:id] != session[:current_id]
    current_data.respond = params[:answer]
    current_data.ready  = true
  end

  get 'status' do
    current_data.ready
  end

  get 'answer' do
    current_data.respond
  end

  def current_data
    EvalData.find(session[:current_id])
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

