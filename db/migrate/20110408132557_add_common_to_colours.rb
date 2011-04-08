class AddCommonToColours < ActiveRecord::Migration
  def self.up
    add_column :colours, :common, :boolean, :default => false, :nil => false
  end

  def self.down
    remove_column :colours, :common
  end
end
