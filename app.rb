require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/post'
require './models/comment'

use Rack::MethodOverride


after do
  ActiveRecord::Base.clear_active_connections!
end

get '/' do
  erb :index
end

post '/submit' do
  @post = Post.new(params[:post])

  if @post.save
    redirect '/posts'
  else
    "Sorry there was an error"
  end
end


get '/posts' do
  @posts = Post.all
  erb :posts
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @comments = @post.comments
  erb :post
end

delete '/posts/:id' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect '/posts'
end

post '/posts/:id/comments' do
  @post = Post.find(params[:id])
  @comment = @post.comments.create(params[:comment])
  if @comment.save
    redirect "/posts"
  else
    "Sorry there was an error"
  end
end
