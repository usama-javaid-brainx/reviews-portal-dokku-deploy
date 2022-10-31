class GroupsController < ApplicationController
  def index
    groups = current_user.groups.all
    @pagy, @groups = pagy(groups, items: 12)
  end

  def show
    @group = current_user.groups.find(params[:id])
    reviews = current_user.groups.find(params[:id]).reviews
    @pagy, @reviews = pagy(reviews, items: 12)
  end

  def create
    debugger
  end

end