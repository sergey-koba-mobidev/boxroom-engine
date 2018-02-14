module Boxroom
  class SearchController < Boxroom::ApplicationController
    include Boxroom::BaseController

    def show
      @folder = get_folder_or_redirect(params[:folder_id])
      @term = params[:term]
      result = Search::FilesAndFolders.(params: {term: @term, folder_id: @folder.id})
      if result.success?
        @folders = result['folders']
        @files = result['files']
      else
        @folders = []
        @files = []
      end
    end
  end
end