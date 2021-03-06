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
      persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Bookmark'
      expect(bookmark.url).to eq 'http://www.example.org'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(url: 'http://wwww.testurl.com', title: 'Test')

      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates the data of an existing bookmark' do
      bookmark = Bookmark.create(url: 'http://wwww.justanothertest.com', title: 'Another test')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.randomurl.com', title: 'Random Url')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Random Url'
      expect(updated_bookmark.url).to eq 'http://www.randomurl.com'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark' do
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq bookmark.title
      expect(result.url).to eq bookmark.url
    end
  end

  describe '.comments' do
    let(:comment_class) { double(:comment_class) }
    it 'return a list of comments' do
      bookmark = Bookmark.create(url: 'http://www.anothertest.com', title: 'Another test')

      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class)
    end
  end

  describe '.tags' do
    it 'returns list of tags' do
      bookmark = Bookmark.create(url: 'http://www.anothertest.com', title: 'Another test')

      DatabaseConnection.query(
        "INSERT INTO tags (id, content) VALUES(1, 'test tag');",
        []
      )
       
      tag = bookmark.tags.first

      expect(tag['content']).to eq 'test tag'

    end
  end
end

