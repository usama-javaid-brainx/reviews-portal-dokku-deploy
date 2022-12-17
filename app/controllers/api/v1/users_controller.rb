# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApiController
      def_param_group(:current_user) do
        property :id, Integer
        property :active?, [true, false]
        param :name, String, required: true
        param :app_platform, String, desc: "Possible values: #{User.app_platforms.keys}", required: true
        param :app_version, String, required: true
        param :device_token, String
      end

      api :GET, "user/profile.json", "Reader Profile"
      returns :current_user, desc: "a successful response"

      def profile
        render json: current_user
      end

      api :POST, "user/change_password.json", "Change Password"
      param :current_password, String, required: true
      param :password, String, required: true
      param :password_confirmation, String, required: true
      returns code: 200, desc: "a successful response" do
        property :message, String
      end

      def change_password
        if params[:password] != params[:password_confirmation]
          render_error(422, I18n.t("devise.passwords.mismatch"))
        elsif current_user.update_with_password(password_resource_params) && current_user.save
          render_message(I18n.t("devise.passwords.updated"))
        else
          render_error(422, current_user.errors.full_messages.first)
        end
      end

      private

      def password_resource_params
        params.permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end
