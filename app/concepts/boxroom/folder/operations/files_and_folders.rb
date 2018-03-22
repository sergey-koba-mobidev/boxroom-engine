module Boxroom
  class Folder < ActiveRecord::Base
    class FilesAndFolders < ::Trailblazer::Operation
      step Trailblazer::Operation::Contract::Build(constant: Boxroom::Folder::Contract::FilesAndFolders)
      step Trailblazer::Operation::Contract::Validate()
      step :get_lists

      def get_lists(options, params:, **)
        folder = Boxroom::Folder.find(params[:folder_id])
        sort_field, sort_dir = params[:sort_field], params[:sort_dir]
        sort_dir = sort_dir == 'asc' ? 'asc' : 'desc'
        options['folders'] = folder.children
        options['files'] = folder.user_files
        case sort_field
          when 'name'
            options['folders'] = options['folders'].reorder("name #{sort_dir}")
            options['files'] = options['files'].reorder("attachment_file_name #{sort_dir}")
          when 'size'
            options['files'] = options['files'].reorder("attachment_file_size #{sort_dir}")
          when 'date'
            options['folders'] = options['folders'].reorder("updated_at #{sort_dir}")
            options['files'] = options['files'].reorder("updated_at #{sort_dir}")
        end
        true
      end
    end
  end
end