class AddPlaqueConnectionsCountToPersonalConnections < ActiveRecord::Migration
  def self.up
    add_column :personal_connections, :plaque_connections_count, :integer

    PersonalConnection.find(:all).each do |personal_connection|
      PersonalConnection.update_counters(personal_connection.id, :plaque_connections_count => PersonalConnection.find(personal_connection.id).plaque_connections.size)
    end


  end

  def self.down
    remove_column :personal_connections, :plaque_connections_count
  end
end
