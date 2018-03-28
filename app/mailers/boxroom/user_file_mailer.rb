module Boxroom
  class UserFileMailer < ActionMailer::Base
    def notify_create(user_file, email)
      @user_file = user_file
      mail(to: email, subject: t(:file_added))
    end

    def notify_update(user_file, email)
      @user_file = user_file
      mail(to: email, subject: t(:file_updated))
    end

    def notify_remove(file_name, folder, email)
      @file_name = file_name
      @folder = folder
      mail(to: email, subject: t(:file_removed))
    end
  end
end