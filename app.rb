require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require './database_connection_setup'
require 'sinatra/flash'
require 'uri'
require './lib/comment'

class BookmarkManager < Sinatra::Base
  # configure :development do
  #   register Sinatra::Reloader
  # end

  enable :method_override
  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
  @bookmarks = Bookmark.all
  erb :'bookmarks/index'    # show option buttons: add, delete, update
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params['url'], title: params['title'])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    # @bookmark_id = params[:id]
    @bookmark = Bookmark.find(id: params[:id]) # to see the current data in the edit form
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    # @bookmark_id = params[:id]
    @bookmark = Bookmark.find(id: params[:id]) # to see the current data in the edit form
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'tags/new'
  end

  post '/bookmarks/:id/tags' do
    con = PG.connect(dbname: 'bookmark_manager_test')
    con.exec_params(
      "INSERT INTO tags(content) VALUES($1);",
      [params[:tag]]
    )
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
