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

      def sort_link(field)
        if @options[:sort_field] == field
          sort_dir = @options[:sort_dir] == 'desc' ? 'asc' : 'desc'
          icon_class = sort_dir == 'asc' ? 'fa-caret-up' : 'fa-caret-down'
        else
          sort_dir = 'asc'
          icon_class = 'fa-caret-down'
        end
        span_class = @options[:sort_field] == field ? 'has-text-link' : 'has-text-grey-lighter'
        path = if request.original_url.include? 'search'
                 search_path(folder_id: folder.id, term: params[:term], sort_field: field, sort_dir: sort_dir)
               else
                 folder_path(folder, sort_field: field, sort_dir: sort_dir)
               end
        link_to "<span class=\"icon is-small #{span_class}\"><i class=\"fa #{icon_class}\"></i></span>", path
      end

    end
  end
end