class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def update_category
    if @categories.update(category_params)
      redirect_to root_path, notice: "Category updated successfully!"
    end
  end
  def move
    @category = Category.find(params[:id])
    @category.insert_at(params[:position].to_i)
  end
  def category_params
    params.require(:category).permit( :active )
  end
end