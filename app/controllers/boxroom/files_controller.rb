module Boxroom
  class FilesController < Boxroom::ApplicationController
    include Boxroom::BaseController

    before_action :require_existing_file, :only => [:show, :edit, :update, :destroy]
    before_action :require_existing_target_folder, :only => [:new, :create]

    before_action :require_create_permission, :only => [:new, :create]
    before_action :require_read_permission, :only => :show
    before_action :require_update_permission, :only => [:edit, :update]
    before_action :require_delete_permission, :only => :destroy

    # @file and @folder are set in require_existing_file
    def show
      send_file @file.attachment.path, :filename => @file.attachment_file_name
    end

    # @target_folder is set in require_existing_target_folder
    def new
      @file = @target_folder.user_files.build
    end

    # @target_folder is set in require_existing_target_folder
    def create
      existing_file = UserFile.where(
          attachment_file_name: permitted_params.user_file["attachment"].original_filename,
          attachment_content_type: permitted_params.user_file["attachment"].content_type,
          folder_id: params[:target_folder_id]
      ).first

      #TODO: refactor to support S3
      if existing_file # Resume upload
        existing_file.update_attribute(:attachment_file_size, existing_file.attachment_file_size + permitted_params.user_file["attachment"].size)
        File.open("#{Rails.root}/#{Boxroom.configuration.uploads_path}/#{Rails.env}/#{existing_file.id}/original/#{existing_file.id}", "ab") {|f| f.write(permitted_params.user_file["attachment"].read)}
      else
        @file = @target_folder.user_files.create(permitted_params.user_file)
        UserFile::NotifyCreate.(params: {id: @file.id})
      end

      head :ok
    end

    # @file and @folder are set in require_existing_file
    def edit
    end

    # @file and @folder are set in require_existing_file
    def update
      if @file.update_attributes(permitted_params.user_file)
        UserFile::NotifyUpdate.(params: {id: @file.id})
        redirect_to edit_file_url(@file), :notice => t(:your_changes_were_saved)
      else
        render :action => 'edit'
      end
    end

    # @file and @folder are set in require_existing_file
    def destroy
      UserFile::NotifyRemove.(params: {id: @file.id})
      @file.destroy
      redirect_to @folder
    end

    def exists
      @folder = Folder.find(params[:folder])

      if boxroom_current_user.can_read(@folder) || boxroom_current_user.can_write(@folder)
        @file = @folder.user_files.build(:attachment_file_name => params[:name].gsub(Boxroom::RESTRICTED_CHARACTERS, '_'))
        render :json => !@file.valid?
      end
    end

    private

    def require_existing_file
      @file = UserFile.find(params[:id])
      @folder = @file.folder
    rescue ActiveRecord::RecordNotFound
      redirect_to Folder.root, :alert => t(:already_deleted, :type => t(:this_file))
    end
  end
end