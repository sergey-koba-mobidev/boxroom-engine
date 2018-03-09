module Boxroom::Search
  class FilesAndFolders < ::Trailblazer::Operation
    step Trailblazer::Operation::Contract::Build(constant: Boxroom::Search::Contract::FilesAndFolders)
    step Trailblazer::Operation::Contract::Validate()
    step :search_tree

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
  end
end