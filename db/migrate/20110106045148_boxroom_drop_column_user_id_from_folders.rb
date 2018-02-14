class BoxroomDropColumnUserIdFromFolders < ActiveRecord::Migration[5.0]
  def self.up
    remove_column :boxroom_folders, :user_id
  end

  def self.down
    add_column :boxroom_folders, :user_id, :integer
  end
end
