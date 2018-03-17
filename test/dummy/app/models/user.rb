class User < ApplicationRecord
  boxroom name: :username, email: :email, is_admin: :is_admin?

  def is_admin?
    email == 'admin@test.com'
  end
end
