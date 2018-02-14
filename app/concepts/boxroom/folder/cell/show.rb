module Boxroom
  module Folder::Cell
    class Show < BaseCell
      include ActionView::Helpers::NumberHelper
      include Boxroom::FoldersHelper

      def folders
        @options[:folders] || []
      end

      def files
        @options[:files] || []
      end

      def current_user
        @options[:current_user]
      end

      def folder
        model
      end

    end
  end
end