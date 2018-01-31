module Boxroom
  class Configuration
    attr_accessor :site_name, :logo, :show_footer, :show_users, :show_groups, :show_settings, :show_shared_files, :sign_out_path

    def initialize
      @site_name     = 'Boxroom'
      @logo          = 'boxroom/logo.png'
      @show_footer   = true
      @show_users    = true
      @show_groups   = true
      @show_settings = true
      @show_shared_files = true
      @sign_out_path = nil
    end
  end
end