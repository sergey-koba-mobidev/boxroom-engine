module Boxroom
  class ApplicationController < "::#{Boxroom.configuration.parent_controller}".constantize
    protect_from_forgery
  end
end