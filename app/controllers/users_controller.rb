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

  private

  def review_filter(reviews)
    params[:to_try] = 'all' unless params[:to_try].present?
    params[:category] = 'all' unless params[:category].present?
    reviews = params[:category] == 'all' ? reviews : reviews.where(category_id: Category.find_by(name: params[:category])) if params[:category].present?

    reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try] == 'true') if params[:to_try].present?
    if params[:to_try] != 'favourite'
      reviews = params[:to_try] == 'all' ? reviews : reviews.where(to_try: params[:to_try] == 'true') if params[:to_try].present?
    else
      reviews = reviews.where(favourite: true) if params[:to_try].present?
    end
    reviews = reviews.order("average_score #{params[:score].to_s} NULLS LAST") if params[:score].present?
    reviews
  end
end
