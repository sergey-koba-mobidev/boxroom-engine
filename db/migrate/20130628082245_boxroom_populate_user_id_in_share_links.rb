class BoxroomPopulateUserIdInShareLinks < ActiveRecord::Migration
  def change
    active_users = Boxroom::User.where.not(:name => nil)

    if active_users.any? && Boxroom::ShareLink.any?
      Boxroom::ShareLink.where(:user_id => nil).update_all(:user_id => active_users.first.id)
    end
  end
end
