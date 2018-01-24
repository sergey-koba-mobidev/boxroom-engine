class AlterColumnTypeIsAdminFromUsers < ActiveRecord::Migration
  def self.up
    change_column :boxroom_users, :is_admin, :boolean
  end

  def self.down
    change_column :boxroom_users, :is_admin, :string
  end
end
