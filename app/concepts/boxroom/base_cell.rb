module Boxroom
  class BaseCell < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Engine.routes.url_helpers
    self.view_paths = ["#{Boxroom::Engine.root}/app/concepts"]
  end
end