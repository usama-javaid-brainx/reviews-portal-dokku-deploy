class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show, :create_review]

  def create_review
    session[:edit_review] = params[:edit_review]
    redirect_to new_user_session_path
  end

  def show
    @review = Review.find(params[:id])
  end
end
