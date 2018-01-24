class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :boxroom_permissions do |t|
      t.references :folder
      t.references :group
      t.boolean :can_create
      t.boolean :can_read
      t.boolean :can_update
      t.boolean :can_delete
    end
  end

  def self.down
    drop_table :boxroom_permissions
  end
end
