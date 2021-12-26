require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')

      DatabaseConnection.setup('bookmark_manager_test')
    end

    it 'this connection is persistent' do
      con = DatabaseConnection.setup('bookmark_manager_test')

      expect(DatabaseConnection.connection).to eq con
    end
  end
end