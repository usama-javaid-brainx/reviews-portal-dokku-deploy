class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:edit, :show, :update, :destroy]

  def index
    @pagy, @restaurants = pagy(current_user.restaurants, items: 2)
  end

  def new
    @restaurant = current_user.restaurants.new
    @restaurant.meals.build
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

  def delete_attachment
    @image = ActiveStorage::Attachment.find(params[:attachment_id])
    @image.purge if @image.present?
  end

  private

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end

  def restaurant_params
    params.require('restaurant').permit(:name, :address, :state, :city, :country, :latitude, :longitude, :place_id, :favorite_dish,
                                        :price_range, :cuisine, :average_score, :notes, images: [])
  #  TODO
  # Favourite_dishes and date(not coming from front end) to added
  end
end
