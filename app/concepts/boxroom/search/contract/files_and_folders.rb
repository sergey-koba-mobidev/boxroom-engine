module Boxroom::Search::Contract
  class FilesAndFolders < Reform::Form
    property :term, virtual: true
    property :folder_id, virtual: true

    validates :folder_id, presence: true
    validates :term, length: {minimum: 3}
  end
end