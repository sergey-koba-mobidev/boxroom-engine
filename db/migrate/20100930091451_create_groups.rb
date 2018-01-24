class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :boxroom_groups do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :boxroom_groups
  end
end
