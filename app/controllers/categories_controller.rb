class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def update_categories_status
    if update_category?
      redirect_to root_path, status: :see_other, notice: "Category updated successfully!"
    else
      redirect_to categories_path
    end
  end

  def update_category?
    params[:categories].each do |category|
      Category.find_by(name: category.first).update(active: category.second)
    end
  end
end