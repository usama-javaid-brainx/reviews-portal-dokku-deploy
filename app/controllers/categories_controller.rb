class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def update_category
    debugger
    if @categories.update(category_params)
      redirect_to root_path, notice: "Category updated successfully!"
    end
  end

  def category_params
    params.require(:category).permit( :active )
  end
end