# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
categories = ["Movies", "Books", "Games", "Restaurants"]
categories.each do |name|
  Category.create(name: name, address: name == 'Restaurants', google_places: name == 'Restaurants', price: true, cuisine: name == 'Restaurants')
end

categories_images = ['videos', 'books', 'games', 'cutlery']
categories.zip(categories_images).each do |category, category_img|
  Category.find_by(name: category).icon.attach(
    io: File.open(Rails.root.join("app/assets/images/template/#{category_img}.svg")),
    filename: "#{category_img}.svg",
    content_type: 'image/svg+xml'
  )
end