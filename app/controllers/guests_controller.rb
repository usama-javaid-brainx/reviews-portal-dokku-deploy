class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show, :create_review]

  def create_review
    session[:edit_review] = params[:edit_review]
    redirect_to new_user_session_path
  end

  def show
    @review = Review.find_by(slug: params[:slug])
    @parent_id = @review.parent_id
  end
end
