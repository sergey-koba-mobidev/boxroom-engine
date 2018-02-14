class BoxroomAddColumnSignupTokenExpiresAtToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :boxroom_users do |t|
      t.datetime :signup_token_expires_at
    end
  end
end
