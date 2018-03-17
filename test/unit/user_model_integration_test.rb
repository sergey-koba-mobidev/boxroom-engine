require 'test_helper'

class UserModelIntegrationTest < ActiveSupport::TestCase
  def setup
    do_cleanup
  end

  test 'required params are provided' do
    assert_raise do
      User.boxroom
    end

    assert_raise do
      User.boxroom name: :username
    end

    assert_raise do
      User.boxroom name: :username, email: :email
    end

    assert_nothing_raised do
      User.boxroom name: :username, email: :email, is_admin: :is_admin?
    end
  end

  test 'duplicates boxroom user' do
    u = User.create(username: 'test', email: 'test@test.com')

    bu = Boxroom::User.find_by_email(u.email)
    assert_equal bu.present?, true
    assert_equal bu.name, u.username
    assert_equal bu.is_admin, false
    assert_equal bu.original_id, u.id
  end

  test 'updates boxroom user' do
    u = User.create(username: 'test', email: 'test@test.com')
    u.update(username: 'test2', email: 'test2@test.com')

    bu = Boxroom::User.find_by_email(u.email)
    assert_equal bu.present?, true
    assert_equal bu.name, u.username
    assert_equal bu.is_admin, false
    assert_equal bu.original_id, u.id
  end

  test 'deletes boxroom user' do
    u = User.create(username: 'test', email: 'test@test.com')

    bu = Boxroom::User.find_by_email(u.email)
    assert_equal bu.present?, true
    assert_equal bu.name, u.username
    assert_equal bu.is_admin, false
    assert_equal bu.original_id, u.id

    u.destroy

    assert_equal 0, Boxroom::User.count
  end

  test 'requires email' do
    assert_raise do
      User.create(username: 'test', email: nil)
    end
  end
end