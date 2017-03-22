require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/post'
require './models/comment'
require './routes/posts'

use Rack::MethodOverride

after do
  ActiveRecord::Base.clear_active_connections!
end

get '/' do
  erb :index
end
