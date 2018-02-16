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
        if result['contract.default'].errors.present?
          flash[:alert] = result['contract.default'].errors.full_messages.uniq.join(', ')
        end
      end
    end
  end
end