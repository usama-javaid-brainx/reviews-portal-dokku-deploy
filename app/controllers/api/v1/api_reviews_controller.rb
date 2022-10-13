module Api
  module V1
    class ApiReviewsController < Api::V1::ApiController
      def jj
        debugger
        if User.find_by(phone_number: params[:phone_number]).present?
          User.find_by(phone_number: params[:phone_number]).review.create(name: "new_review", category_id: 13, to_try: true, url: params[:url])
        else
          render plain: 'user dose not exit'
        end
      end
    end
  end
end
