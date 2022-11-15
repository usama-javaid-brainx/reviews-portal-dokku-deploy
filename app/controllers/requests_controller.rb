class RequestsController < ApplicationController
  def create
    @request = current_user.requests.new(request_params)
    if @request.save
      redirect_to reviews_path, status: :see_other, notice: "New category request added successfully!"
    else
      render categories_index_path
    end
  end

  def request_params
    params.require(:request).permit(:name, :email, :category_name, :description)
  end
end