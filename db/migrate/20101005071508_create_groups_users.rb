class CreateGroupsUsers < ActiveRecord::Migration
  def self.up
    create_table :boxroom_groups_users, :id => false do |t|
      t.references :group
      t.references :user
    end
  end

  def self.down
    drop_table :boxroom_groups_users
  end
end
