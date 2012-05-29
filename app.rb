require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra-websocket'

class App < Sinatra::Base
  register Sinatra::Reloader
  set :server, 'thin'
  set :sockets, []
  enable :logging

  not_found do
    erb :"404.html"
  end

  get '/about' do
    erb :"about.html"
  end

  get '/' do
    if !request.websocket?
      @ruby_v = RUBY_VERSION.match(/1.[8-9].[0-9]/).to_s
      erb :"ws.html"
    else
      request.websocket do |ws|
        ws.onmessage do |msg|
          respond = evaluate(msg)
          ws.send(respond)
          settings.sockets << ws
        end
        ws.onclose do
          warn("websocket closed")
          settings.sockets.delete(ws)
        end
      end
    end
  end

  def evaluate(message)
    unless message.nil?
      return "StandardError: Can't process this line!" if unacceptable_command?(message)
      begin
        respond = eval(message)
        " => #{respond.nil? ? 'nil' : respond }"
      rescue Exception => ex
        ex.to_s
      end
    else
      "nil"
    end
  end

  # check for system evaluation commands
  def unacceptable_command?(command)
    # array of denied commands in regexp
    [
      /system[\s(]/,
      /exec[\s(]/,
      /eval[\s(]/,
      /%x\[/
    ].each do |regexp|
      return true unless command.scan(regexp).empty?
    end
    false
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

