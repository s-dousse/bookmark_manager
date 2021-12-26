require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require './database_connection_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  
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
    if params['url'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.create(url: params[:url], title: params[:title])
    else
      flash[:notice] = "You must submit a valid URL."
    end
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  post '/bookmarks/:id/edit' do
    # @bookmark_id = params[:id]
    @bookmark = Bookmark.find(id: params[:id]) # to see the current data in the edit form
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
