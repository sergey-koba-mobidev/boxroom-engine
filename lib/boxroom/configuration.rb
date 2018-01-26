module Boxroom
  class Configuration
    attr_accessor :site_name, :logo, :show_footer

    def initialize
      @site_name = 'Boxroom'
      @logo = 'boxroom/logo.png'
      @show_footer = true
    end
  end
end