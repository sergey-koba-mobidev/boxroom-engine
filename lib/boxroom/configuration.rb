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
                  :enable_notifications,
                  :uploads_path,
                  :current_user_method,
                  :sign_in_path,
                  :sign_out_path,
                  :parent_controller

    def initialize
      @site_name            = 'Boxroom'
      @logo                 = 'boxroom/logo.png'
      @show_footer          = true
      @show_users           = true
      @show_groups          = true
      @show_settings        = true
      @show_shared_files    = true
      @show_search          = true
      @enable_notifications = true
      @uploads_path         = 'uploads'

      # Integrate with existing user model
      @current_user_method = nil
      @sign_in_path        = nil
      @sign_out_path       = nil

      @parent_controller = 'ApplicationController'
    end
  end
end