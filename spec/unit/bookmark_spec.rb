require 'bookmark'

describe 'Bookmark' do
  describe '.all' do
    it 'returns all the bookmarks' do
      # create the connection to DB
      con = PG.connect(dbname: 'bookmark_manager_test')

      # populate the table
      con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
      con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.codecademy.com');")
      con.exec("INSERT INTO bookmarks (url) VALUES ('http://wwww.udemy.com');")

      bookmarks = Bookmark.all

      expect(bookmarks).to be_an Array
      expect(bookmarks).to include 'http://www.makersacademy.com'
      expect(bookmarks).to include 'http://www.codecademy.com'
      expect(bookmarks).to include 'http://wwww.udemy.com'
    end
  end
end
