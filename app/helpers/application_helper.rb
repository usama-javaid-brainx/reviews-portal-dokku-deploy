module ApplicationHelper
  include Pagy::Frontend

  def show_svg(blob)
    blob.open do |file|
      raw file.read
    end
  end
end
