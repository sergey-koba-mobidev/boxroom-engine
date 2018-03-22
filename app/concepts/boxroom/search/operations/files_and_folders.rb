module Boxroom::Search
  class FilesAndFolders < ::Trailblazer::Operation
    step Trailblazer::Operation::Contract::Build(constant: Boxroom::Search::Contract::FilesAndFolders)
    step Trailblazer::Operation::Contract::Validate()
    step :search_tree
    step :sort_results

    def search_tree(options, params:, **)
      options['files'], options['folders'] = [], []
      folder = Boxroom::Folder.find(params[:folder_id])
      search_folder(params[:term], folder, options)
    end

    def search_folder(term, folder, options)
      options['folders'] << folder if folder.name.downcase.include? term.downcase
      options['files'] += folder.user_files.where('lower(attachment_file_name) LIKE ?', "%#{term.downcase}%").all.to_a
      folder.children.each do |f|
        search_folder(term, f, options)
      end
    end

    def sort_results(options, params:, **)
      sort_field, sort_dir = params[:sort_field], params[:sort_dir]
      sort_dir = sort_dir == 'asc' ? 'asc' : 'desc'
      case sort_field
        when 'name'
          options['folders'] = options['folders'].sort_by {|f| f.name}
          options['files'] = options['files'].sort_by {|f| f.attachment_file_name}
          options['folders'] = options['folders'].reverse if sort_dir == 'desc'
        when 'size'
          options['files'] = options['files'].sort_by {|f| f.attachment_file_size}
        when 'date'
          options['folders'] = options['folders'].sort_by {|f| f.updated_at}
          options['files'] = options['files'].sort_by {|f| f.updated_at}
          options['folders'] = options['folders'].reverse if sort_dir == 'desc'
      end
      options['files'] = options['files'].reverse if sort_dir == 'desc'
      true
    end
  end
end