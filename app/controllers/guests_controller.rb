class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :create_review]
  before_action :set_categories, only: [:show]
  def create_review
    session[:edit_review] = params[:edit_review]
    redirect_to new_user_session_path
  end

  def show
    @review = Review.find_by(slug: params[:id])
    if @review.shareable
      @parent_id = @review.parent_id
      @review_user = User.find_by(id: @review.user_id)
    else
      redirect_to current_user.present? ? reviews_path : new_user_session_path, alert: "Sorry Review is not public"
    end
  end
end
