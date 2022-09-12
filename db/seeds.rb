# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

["Restaurants", "Games", "Books", "Movies"].each do |name|
  Category.create(name: name, address: name == 'Restaurants', google_places: name == 'Restaurants', price: true, cuisine: name == 'Restaurants')
end

Category.find_by(name: "Movies").icon.attach(
  io: File.open(Rails.root.join("app/assets/images/template/videos.svg")),
  filename: "videos.svg",
  content_type: 'image/svg+xml'
)

Category.find_by(name: "Books").icon.attach(
  io: File.open(Rails.root.join("app/assets/images/template/books.svg")),
  filename: "books.svg",
  content_type: 'image/svg+xml'
)

Category.find_by(name: "Games").icon.attach(
  io: File.open(Rails.root.join("app/assets/images/template/games.svg")),
  filename: "games.svg",
  content_type: 'image/svg+xml'
)

Category.find_by(name: "Restaurants").icon.attach(
  io: File.open(Rails.root.join("app/assets/images/template/cutlery.svg")),
  filename: "cutlery.svg",
  content_type: 'image/svg+xml'
)