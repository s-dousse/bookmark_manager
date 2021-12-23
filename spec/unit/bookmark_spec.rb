require 'bookmark'
require 'database_helpers'

describe 'Bookmark' do
  describe '.all' do
    it 'returns all the bookmarks' do
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy all Software')

      bookmarks = Bookmark.all
      # p bookmarks
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end
  
  describe '.create' do
   it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.example.org'
    end
  end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(url: 'wwww.testurl.com', title: 'Test')

      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the data of an existing bookmark' do
      bookmark = Bookmark.create(url: 'wwww.justanothertest.com', title: 'Another test')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'www.randomurl.com', title: 'Random Url')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Random Url'
      expect(updated_bookmark.url).to eq 'www.randomurl.com'
    end
  end
end

