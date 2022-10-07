class FileUploadsController < ApplicationController
  def upload
    image = current_user.ck_editor_images.new(file: params["upload"])
    if image.save
      render json: {
        url: url_for(image.file)
      }
    else
      render json: {
        "error": {
          "message": image.errors.full_messages.join(", ")
        }
      }
    end
  end
end
