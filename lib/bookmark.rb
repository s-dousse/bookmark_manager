require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'],
        title: bookmark['title'],
        url: bookmark['url']
      )
    end
  end


  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end

    rs = con.exec_params("INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title])

    Bookmark.new(
      id: rs[0]['id'],
      title: rs[0]['title'],
      url: rs[0]['url']
    )
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end

    con.exec_params("DELETE FROM bookmarks WHERE id = $1", [id])
  end

  def self.update(id:, url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end

    rs = con.exec_params("UPDATE bookmarks SET url = $1, title = $2 WHERE id = $3
                    RETURNING id, url, title",
                    [url, title, id])
    Bookmark.new(
      id: rs[0]['id'],
      url: rs[0]['url'],
      title: rs[0]['title']
    )
  end
end
