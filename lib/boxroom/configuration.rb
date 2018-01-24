module Boxroom
  class Configuration
    attr_accessor :site_name, :logo

    def initialize
      @site_name = 'Boxroom'
      @logo = 'boxroom/logo.png'
    end
  end
end