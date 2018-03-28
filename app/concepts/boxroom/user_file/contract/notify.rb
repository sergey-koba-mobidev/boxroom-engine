module Boxroom::UserFile::Contract
  class Notify < Reform::Form
    property :id, virtual: true

    validates :id, presence: true
  end
end