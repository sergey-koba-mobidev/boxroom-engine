module Boxroom
  class Configuration
    attr_accessor :site_name,
                  :logo,
                  :show_footer,
                  :show_users,
                  :show_groups,
                  :show_settings,
                  :show_shared_files,
                  :show_search,
                  :sign_out_path,
                  :uploads_path

    def initialize
      @site_name         = 'Boxroom'
      @logo              = 'boxroom/logo.png'
      @show_footer       = true
      @show_users        = true
      @show_groups       = true
      @show_settings     = true
      @show_shared_files = true
      @show_search       = true
      @sign_out_path     = nil
      @uploads_path      = 'uploads'
    end
  end
end