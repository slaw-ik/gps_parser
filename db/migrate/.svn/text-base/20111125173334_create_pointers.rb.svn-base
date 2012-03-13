class CreatePointers < ActiveRecord::Migration
  def self.up
    create_table :pointers do |t|
      t.float :latitude
      t.float :longitude
      t.string :description
      t.text :full_desc
      t.boolean :gmaps

      t.timestamps
    end
  end

  def self.down
    drop_table :pointers
  end
end
