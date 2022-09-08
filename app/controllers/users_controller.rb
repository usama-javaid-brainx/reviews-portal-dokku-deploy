class UsersController < ApplicationController
  def index
    reviews = review_filter(current_user.reviews.kept)
    @pagy, @reviews = pagy(reviews, items: 12)
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
end