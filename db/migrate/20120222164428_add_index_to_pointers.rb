class AddIndexToPointers < ActiveRecord::Migration
  def self.up
    add_index :pointers, [:latitude, :longitude], :unique => true
  end

  def self.down
  end
end
