class BoxroomDropColumnAccessKeyFromUsers < ActiveRecord::Migration[5.0]
  def self.up
    remove_column :boxroom_users, :access_key
  end

  def self.down
    add_column :boxroom_users, :access_key, :string
  end
end
