require 'sinatra'
require 'sinatra/reloader'
require './models/post_file'
require './models/unique_id'
require './models/post'

get '/' do
  @post_file = PostFile.new
  posts = @post_file.all()
  posts = @post_file.sort(posts)
  erb :top, :locals => { :names => posts, :action => params[:action] }
end

get '/posts/new' do
  erb :new_memo
end

post '/posts' do
  @unique_id = UniqueID.new
  id = @unique_id.id()
  post = Post.new(id, params[:memo])
  @post_file = PostFile.new
  @post_file.write(post)
  @unique_id.increment()
  redirect to("/posts/#{id}?action=posted"), 303
end

get '/posts/:name' do
  @post_file = PostFile.new
  post = @post_file.read(params[:name])
  erb :show_memo, :locals => { :name => post.name, :memo => post.memo, :action => params[:action] }
end

get '/posts/:name/edit' do
  @post_file = PostFile.new
  post = @post_file.read(params[:name])
  erb :edit_memo, :locals => { :name => post.name, :memo => post.memo }
end

patch '/posts/:name' do
  @post_file = PostFile.new
  post = Post.new(params[:name], params[:memo])
  @post_file.write(post)
  redirect to("/posts/#{post.name}?action=updated"), 303
end

delete '/posts/:name' do
  @post_file = PostFile.new
  @post_file.delete(params[:name])
  redirect to('?action=deleted'), 303
end
