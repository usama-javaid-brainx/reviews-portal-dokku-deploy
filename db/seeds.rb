# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create(name: "Games", address: false, google_places: false, price: true, cuisine: false)
Category.create(name: "Books", address: false, google_places: false, price: true, cuisine: false)
Category.create(name: "Movies", address: false, google_places: false, price: true, cuisine: false)
Category.create(name: "Restaurants", address: true, google_places: true, price: true, cuisine: true)
