require 'PG'

class DatabaseConnection
  def self.setup(dbname)
    @conection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end
end
