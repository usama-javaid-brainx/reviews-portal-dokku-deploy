class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :create_review]

  def create_review
    session[:edit_review] = params[:edit_review]
    redirect_to new_user_session_path
  end

  def show
    @review = Review.find(params[:id])
    @parent_id = Review.find_by(id: params[:id]).parent_id
    @review_user = User.find_by(id: @review.user_id)
  end
end
