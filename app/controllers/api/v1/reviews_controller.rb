class Api::V1::ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create_review]

  def create_review
    if "9669e8488b0728d430ed1ce463097484" == request.headers["x-api-key"]    #secret_key = params { 'secret_key' }
      if User.find_by(phone_number: params[:phone_number]).present?
        review = User.find_by(phone_number: params[:phone_number]).reviews.new(name: "new_review", category_id: 13, to_try: true, url: params[:url])
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
