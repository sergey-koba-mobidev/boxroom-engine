require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    clear_root_folder
    do_cleanup
  end

  test 'notify file was created in folder' do
    folder = create(:folder, notify_emails: 'test@test.com')
    file = create(:user_file, folder: folder)

    Boxroom::UserFile::NotifyCreate.(params: {id: file.id})
    email = ActionMailer::Base.deliveries.last
    assert_nil email

    folder.update_attribute :notify_create, true

    Boxroom::UserFile::NotifyCreate.(params: {id: file.id})

    email = ActionMailer::Base.deliveries.last

    assert email != nil
    assert_equal ['test@test.com'], email.to
    assert_equal I18n.t(:file_added), email.subject
    assert_equal true, email.body.to_s.include?(file.attachment_file_name)
    assert_equal true, email.body.to_s.include?(folder.name)
  end

  test 'notify file was updated in folder' do
    folder = create(:folder, notify_emails: 'test@test.com')
    file = create(:user_file, folder: folder)

    Boxroom::UserFile::NotifyUpdate.(params: {id: file.id})
    email = ActionMailer::Base.deliveries.last
    assert_nil email

    folder.update_attribute :notify_update, true

    Boxroom::UserFile::NotifyUpdate.(params: {id: file.id})

    email = ActionMailer::Base.deliveries.last

    assert email != nil
    assert_equal ['test@test.com'], email.to
    assert_equal I18n.t(:file_updated), email.subject
    assert_equal true, email.body.to_s.include?(file.attachment_file_name)
    assert_equal true, email.body.to_s.include?(folder.name)
  end

  test 'notify file was deleted in folder' do
    folder = create(:folder, notify_emails: 'test@test.com')
    file = create(:user_file, folder: folder)

    Boxroom::UserFile::NotifyRemove.(params: {id: file.id})
    email = ActionMailer::Base.deliveries.last
    assert_nil email

    folder.update_attribute :notify_remove, true

    Boxroom::UserFile::NotifyRemove.(params: {id: file.id})

    email = ActionMailer::Base.deliveries.last

    assert email != nil
    assert_equal ['test@test.com'], email.to
    assert_equal I18n.t(:file_removed), email.subject
    assert_equal true, email.body.to_s.include?(file.attachment_file_name)
    assert_equal true, email.body.to_s.include?(folder.name)
  end

  test 'notification sent to many recipients' do
    folder = create(:folder, notify_emails: 'test@test.com, test2@test.com', notify_create: true)
    file = create(:user_file, folder: folder)

    Boxroom::UserFile::NotifyCreate.(params: {id: file.id})

    assert_equal 2, ActionMailer::Base.deliveries.size
  end
end