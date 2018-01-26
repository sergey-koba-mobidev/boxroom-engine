module Boxroom
  class Configuration
    attr_accessor :site_name, :logo, :show_footer, :sign_out_path

    def initialize
      @site_name = 'Boxroom'
      @logo = 'boxroom/logo.png'
      @show_footer = true
      @sign_out_path = nil
    end
  end
end