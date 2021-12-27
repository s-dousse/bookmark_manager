# require_relative '../lib/database_connection.rb'
require 'pg'

def persisted_data(table:, id:)
  # #DatabaseConnection.setup(dbname: 'bookmark_manager_test')
  # DatabaseConnection.query(
  #   "SELECT * FROM $1 WHERE id = $2;",
  #   [table, id]
  # )
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end