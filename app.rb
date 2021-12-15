require 'sinatra/base'
require 'sinatra/reloader'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/bookmarks' do
  bookmarks = [
    "www.makersacademy.com",
    "www.codecademy.com",
    "wwww.udemy.com"
  ]
  bookmarks.join
  end

  run! if app_file == $0
end