module Boxroom::Search::Contract
  class FilesAndFolders < Reform::Form
    property :term, virtual: true
    property :folder_id, virtual: true

    validates :term, :folder_id, presence: true
  end
end