module Boxroom
  class UserFile < ActiveRecord::Base
    class NotifyCreate < ::Trailblazer::Operation
      step Trailblazer::Operation::Contract::Build(constant: Boxroom::UserFile::Contract::Notify)
      step Trailblazer::Operation::Contract::Validate()
      step :model!
      step :check
      step :notify

      def model!(options, params:, **)
        options['model'] = UserFile.find(params[:id])
      end

      def check(options, params:, **)
        return false unless Boxroom.configuration.enable_notifications
        return false unless options['model'].folder.notify_create
        true
      end

      def notify(options, params:, **)
        options['model'].folder.notify_emails.gsub(',', ' ').split.each do |email|
          UserFileMailer.notify_create(options['model'], email).deliver_later
        end
      end
    end
  end
end
