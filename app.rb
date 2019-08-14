require 'sinatra'
require 'sinatra/reloader'
require './models/post'
require './models/unique_id.rb'

get '/' do
  Post.init
  UniqueID.init
  posts = Post.all
  erb :top, :locals => { :names => posts, :action => params[:action] }
end

get '/posts/new' do
  erb :new_memo
end

post '/posts' do
  id = UniqueID.id
  post = Post.new(id, params[:memo])
  post.save
  redirect to("/posts/#{id}?action=posted"), 303
end

get '/posts/:name' do
  post = Post.find(params[:name])
  erb :show_memo, :locals => { :name => post.name, :memo => post.memo, :action => params[:action] }
end

get '/posts/:name/edit' do
  post = Post.find(params[:name])
  erb :edit_memo, :locals => { :name => post.name, :memo => post.memo }
end

patch '/posts/:name' do
  post = Post.new(params[:name], params[:memo])
  post.save
  redirect to("/posts/#{post.name}?action=edited"), 303
end

delete '/posts/:name' do
  post = Post.find(params[:name])
  post.destroy
  redirect to('?action=deleted'), 303
end
