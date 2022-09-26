module ApplicationHelper
  include Pagy::Frontend

  def show_svg(blob)
    puts( blob)
    puts(blob.icon.attached?)
    blob.open do |file|
      raw file.read
    end
  end
end
