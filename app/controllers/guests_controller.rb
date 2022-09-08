class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show]

  def show
    @review = Review.find(params[:id])
  end
end
