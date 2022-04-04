class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:edit, :show, :update, :destroy]

  def index
    @restaurants = current_user.restaurants
  end

  def new
    @restaurant = current_user.restaurants.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path, notice: "Restaurant created successfully!"
    else
      render :new
    end
  end

  def show
  end

  def edit
    render :new
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurants_path, notice: "Restaurant updated successfully!"
    else
      render :new
    end
  end

  def destroy
    redirect_to restaurants_path, notice: "Restaurant deleted successfully!" if @restaurant.destroy
  end

  private

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end

  def restaurant_params
    params.require('restaurant').permit(:name, :country, :city, :favorite_dish, :cuisine, :average_score, :notes, :date, :google_maps_link, images: [])
  end
end
