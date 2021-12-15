require 'bookmark'

describe 'Bookmark' do
  describe '.all' do
    it 'returns all the bookmarks' do
      bookmarks = Bookmark.all

      expect(bookmarks).to be_an Array
      expect(bookmarks).to include "www.makersacademy.com"
      expect(bookmarks).to include "www.codecademy.com"
      expect(bookmarks).to include "wwww.udemy.com"
    end
  end
end