module Boxroom
  module BaseController
    extend ActiveSupport::Concern

    included do
      before_action :require_admin_in_system
      before_action :require_login

      helper_method :clipboard, :boxroom_current_user, :signed_in?, :permitted_params

      %w{read update delete}.each do |method|
        define_method "require_#{method}_permission" do
          unless (method == 'read' && @folder.is_root?) || boxroom_current_user.send("can_#{method}", @folder)
            redirect_folder = @folder.parent.nil? ? Folder.root : @folder.parent
            redirect_to redirect_folder, :alert => t(:no_permissions_for_this_type, :method => t(:create), :type => t(:this_folder))
          end
        end
      end
    end

    protected

    def clipboard
      cl = session[:clipboard]
      cl = Clipboard.new if cl.nil?
      if cl.kind_of? Hash # Init clipboard from Hash
        new_cl = Clipboard.new
        cl['folders'].each do |folder_id|
          new_cl.add(Folder.find(folder_id))
        end
        cl['files'].each do |file_id|
          new_cl.add(UserFile.find(file_id))
        end
        cl = new_cl
      end
      cl
    end

    def boxroom_current_user
      # integrate with existing User model
      if Boxroom.configuration.current_user_method && @current_user.nil?
        original_user = send(Boxroom.configuration.current_user_method)
        boxroom_user = User.find_by_original_id(original_user.id)
        session[:boxroom_user_id] = boxroom_user.id if boxroom_user
      end

      @current_user ||= User.find_by_id(session[:boxroom_user_id])
    end

    def signed_in?
      !!boxroom_current_user
    end

    def permitted_params
      @permitted_params ||= PermittedParams.new(params, boxroom_current_user)
    end

    def require_admin_in_system
      redirect_to new_admin_url if User.no_admin_yet?
    end

    def require_admin
      redirect_to :root unless boxroom_current_user.member_of_admins?
    end

    def require_login
      if boxroom_current_user.nil?
        user = User.find_by_remember_token(cookies[:auth_token]) unless cookies[:auth_token].blank?

        if user.nil?
          reset_session
          session[:boxroom_user_id] = nil
          session[:return_to] = request.fullpath
          redirect_to new_session_url
        else
          user.refresh_remember_token
          session[:boxroom_user_id] = user.id
          cookies[:auth_token] = user.remember_token
        end
      end
    end

    def require_existing_target_folder
      @target_folder = get_folder_or_redirect(params[:folder_id])
    end

    def require_create_permission
      unless boxroom_current_user.can_create(@target_folder)
        redirect_to @target_folder, :alert => t(:no_permissions_for_this_type, :method => t(:create), :type => t(:this_folder))
      end
    end

    def get_folder_or_redirect(id)
      Folder.find(id)
    rescue ActiveRecord::RecordNotFound
      redirect_to Folder.root, :alert => t(:already_deleted, :type => t(:this_folder))
    end
  end
end