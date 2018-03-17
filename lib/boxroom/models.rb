module Boxroom
  module Models
    module ClassMethods
      def boxroom(params)
        throw "Provide 'name:' param for 'boxroom' method in your user model" if params[:name].nil?
        throw "Provide 'email:' param for 'boxroom' method in your user model" if params[:email].nil?
        throw "Provide 'is_admin:' param for 'boxroom' method in your user model" if params[:is_admin].nil?

        after_save -> { save_boxroom_user(params) }
        before_destroy -> { destroy_boxroom_user(params) }
      end
    end

    module InstanceMethods
      def save_boxroom_user(params)
        bu = Boxroom::User.find_by_original_id(id)
        bu = Boxroom::User.new if bu.nil?
        bu.original_id = id
        bu.name = send(params[:name])
        bu.email = send(params[:email])
        bu.is_admin = send(params[:is_admin])
        bu.save
        throw "Failed to save Boxroom::User with email=#{bu.email}" unless bu.persisted?
      end

      def destroy_boxroom_user(params)
        bu = Boxroom::User.find_by_original_id(id)
        bu.destroy if bu
        true
      end
    end
  end
end