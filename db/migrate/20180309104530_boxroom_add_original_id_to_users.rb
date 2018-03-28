class BoxroomAddOriginalIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :boxroom_users, :original_id, :integer
  end
end
