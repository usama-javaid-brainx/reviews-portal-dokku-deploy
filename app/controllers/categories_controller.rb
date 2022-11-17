class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def update_categories_status
    if update_category?
      redirect_to reviews_path, status: :see_other, notice: "Category updated successfully!"
    else
      redirect_to categories_path
    end
  end

  def update_category?
    params[:categories].each do |category|
      Category.find(category.first).update(active: category.second)
    end
    params[:positions].each do |position|
      Category.find(position.first).update(position: position.second)
    end
  end
end