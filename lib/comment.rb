class Comment
  attr_reader :id, :text, :bookmark_id

  def initialize(id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.create(text:, bookmark_id:)
   rs = DatabaseConnection.query(
      "INSERT INTO comments (text, bookmark_id) VALUES($1, $2) RETURNING id, text, bookmark_id;",
      [text, bookmark_id]
    )
    rs = Comment.new(
      id: rs[0]['id'],
      text: rs[0]['text'],
      bookmark_id: rs[0]['bookmark_id']
    )
  end

  def self.where(bookmark_id:)
    rs = DatabaseConnection.query(
      "SELECT * FROM comments WHERE bookmark_id = $1;",
      [bookmark_id]
    )
    rs.map do |comment|
      Comment.new(
        id: comment['id'],
        text: comment['text'],
        bookmark_id: comment['bookmark_id']
      )
    end
  end
end