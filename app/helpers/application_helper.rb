module ApplicationHelper
  include Pagy::Frontend

  def show_svg(blob)
    blob.open do |file|
      puts(raw file.read)
      raw file.read
    end
  end
end
