require 'boxroom/engine'
require 'boxroom/configuration'
require 'boxroom/models'
require 'boxroom/active_record'

require 'dynamic_form'
require 'jquery-rails'
require 'jquery-fileupload-rails'
require 'acts_as_tree'
require 'paperclip'
require 'paperclip/spoof_detector'
require 'bulma-rails'
require 'font-awesome-rails'

require 'cells/rails'
require 'cells-erb'
require 'trailblazer/cell'
require 'trailblazer-rails'

module Boxroom
  RESTRICTED_CHARACTERS = /[&$+,\/:;=?@<>\[\]\{\}\|\\\^~%# ]/

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
