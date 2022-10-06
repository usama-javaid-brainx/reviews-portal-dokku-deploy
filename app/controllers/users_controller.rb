class UsersController < ApplicationController
  before_action :set_categories, only: [:index, :settings, :edit]
  before_action :set_user, only: [:update]

  def index
    reviews = review_filter(current_user.reviews.kept)
    @pagy, @reviews = pagy(reviews, items: 12)
  end

  def update
    if params[:user][:password].present?
      if @user.valid_password?(params[:user][:current_password]) && @user.update(password: params[:user][:password]) && @user.update(user_params)
        bypass_sign_in(@user)
        redirect_to reviews_path, notice: "User profile updated successfully"
      else
        redirect_to edit_user_registration_path, alert: "Password did not match try again"
      end
    else
      if @user.update(user_params)
        redirect_to reviews_path, notice: "User profile updated successfully"
      else
        redirect_to edit_user_registration_path, alert: "User profile did not updated try again"
      end
    end
  end

  def remove_avatar
    if current_user.avatar.attached?
      @avatar = ActiveStorage::Attachment.find(current_user.avatar.id)
      @avatar.purge
    end
    redirect_to edit_user_registration_path
  end

  def delete_user
    if current_user.discard
      sign_out if Devise.sign_out_all_scopes
      redirect_to after_sign_out_path_for(:user), notice: "Your Account Deleted successfully"
    else
      redirect_to edit_user_registration_path
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :avatar)
  end
end