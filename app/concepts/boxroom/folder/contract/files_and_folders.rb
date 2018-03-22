module Boxroom::Folder::Contract
  class FilesAndFolders < Reform::Form
    property :folder_id, virtual: true
    property :sort_field, virtual: true
    property :sort_dir, virtual: true

    validates :folder_id, presence: true
  end
end