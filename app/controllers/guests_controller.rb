class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show, :new_user]

  def new_user
    debugger
  end

  def show
    @review = Review.find(params[:id])
  end
end
