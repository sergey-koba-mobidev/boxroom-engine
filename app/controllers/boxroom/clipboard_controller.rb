module Boxroom
  class ClipboardController < Boxroom::ApplicationController
    include Boxroom::BaseController

    before_action :require_existing_item, :except => :reset
    before_action :require_existing_target_folder, :only => [:copy, :move]
    before_action :require_target_is_not_child, :only => :move
    before_action :require_create_permission, :only => [:copy, :move]
    before_action :require_read_permission, :only => [:create, :copy, :move]
    before_action :require_delete_permission, :only => :move

    # @item is set in require_existing_item
    def create
      cl = clipboard
      cl.add(@item)
      session[:clipboard] = cl
      redirect_to folder_url(params[:folder_id]), :notice => t(:added_to_clipboard)
    end

    # @item is set in require_existing_item
    def destroy
      cl = clipboard
      cl.remove(@item)
      session[:clipboard] = cl
      redirect_to folder_url(params[:folder_id])
    end

    def reset
      cl = clipboard
      cl.reset
      session[:clipboard] = cl
      redirect_to folder_url(params[:folder_id])
    end

    def copy
      paste :copy
    end

    def move
      paste :move
    end

    private

    # @item is set in require_existing_item
    # @target_folder is set in require_existing_target_folder
    def paste(action)
      @item.send(action, @target_folder)
      cl = clipboard
      cl.remove(@item)
      session[:clipboard] = cl
      redirect_to folder_url(params[:folder_id])
    rescue ActiveRecord::RecordInvalid
      redirect_to folder_url(params[:folder_id]), :alert => t("could_not_#{action}", :type => t(params[:type]))
    end

    def require_existing_item
      if params[:type] == 'folder'
        @item = @folder = Folder.find(params[:id])
      else
        @item = UserFile.find(params[:id])
        @folder = @item.folder
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to folder_url(params[:folder_id]), :alert => t(:already_deleted, :type => t("this_#{params[:type]}"))
    end

    def require_target_is_not_child
      if params[:type] == 'folder'
        if @folder == @target_folder || @folder.parent_of?(@target_folder)
          redirect_to folder_url(params[:folder_id]), :alert => t(:cannot_move_to_own_subfolder)
        end
      end
    end

    # Overrides require_#{method}_permission in ApplicationController.
    # Check if @folder can be read or deleted and redirects to the
    # current folder (identified by params[:folder_id]) if not.
    %w{read delete}.each do |method|
      define_method "require_#{method}_permission" do
        unless boxroom_current_user.send("can_#{method}", @folder)
          redirect_to folder_url(params[:folder_id]), :alert => t(:no_permissions_for_this_type, :method => t(method), :type => t("this_#{params[:type]}"))
        end
      end
    end
  end
end