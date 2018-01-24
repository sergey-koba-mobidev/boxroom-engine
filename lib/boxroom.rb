require "boxroom/engine"
require "dynamic_form"
require 'jquery-fileupload-rails'
require 'acts_as_tree'
require 'paperclip'
require 'boxroom/configuration'
require 'paperclip/media_type_spoof_detector'

module Boxroom
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
