require 'pg'
require 'uri'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end

  def self.all
    rs = DatabaseConnection.query("SELECT * FROM bookmarks")

    rs.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end


  def self.create(url:, title:)
    # only create a Bookmark if url is valid
    return false unless is_url?(url)
    rs = DatabaseConnection.query(
      "INSERT INTO bookmarks (url, title) VALUES($1, $2)
      RETURNING id, title, url;",
      [url, title]
    )

    Bookmark.new(
      id: rs[0]['id'],
      title: rs[0]['title'],
      url: rs[0]['url']
    )
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = $1", [id])
  end

  def self.update(id:, url:, title:)
    rs = DatabaseConnection.query(
      "UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3 RETURNING id, url, title;",
      [url, title, id]
    )
    Bookmark.new(
      id: rs[0]['id'],
      title: rs[0]['title'],
      url: rs[0]['url']
    )
end

 def self.find(id:)
    rs = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = $1;", [id])

    Bookmark.new(
      id: rs[0]['id'],
      title: rs[0]['title'],
      url: rs[0]['url']
    )
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  private
  
  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
