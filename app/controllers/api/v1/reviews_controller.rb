class Api::V1::ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    if Rails.application.credentials.config[:x_api_key] == request.headers["x-api-key"]
      debugger
      puts params
      puts params[:phone_number]
      puts params[:url]
      if User.find_by(phone_number: params[:phone_number]).present?
        review = User.find_by(phone_number: params[:phone_number]).reviews.new(name: "new_review", category_id: Category.find_by(name: "Others").id, to_try: true, url: params[:url])
        if review.save
          message("#{request.env['rack.url_scheme']}://#{request.host_with_port}/reviews/#{review.id}/edit")
        else
          message("review did not created success fully please try again")
        end
      else
        message("user dose not exit with this phone number")
      end
    else
      message("invalid secret key")
    end
  end

  def message(msg)
    render json: {
      message: msg
    }
  end
end
