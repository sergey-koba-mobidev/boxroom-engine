class BoxroomAddNotificationsToFolders < ActiveRecord::Migration[5.1]
  def change
    change_table :boxroom_folders do |t|
      t.string  :notify_emails
      t.boolean :notify_create
      t.boolean :notify_update
      t.boolean :notify_remove
    end
  end
end
