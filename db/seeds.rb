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

categorys = ['Genres', 'Genres', 'Genres', 'Cuisine']
categorys.each_with_index do |category, index|
  Category.find_by(id: index + 1).update(sub_category_title: category)
end

sub_categorys = { movie_sub_categories: "Action, Science fiction, Thriller, Adventure, Heist, Drama",
                  book_sub_categories: "Adventure, Art & Photography, Biography, Business & Money, Children’s Fiction, Cooking, Crafts, Hobbies & Home, Detective & Mystery, Dystopian, Education & Teaching, Families & Relationships, Health & Fitness, Historical Fiction, History, Horror, Humor & Entertainment, Law & Criminology, LGBTQ+, Memoir & Autobiography, Motivational / Inspirational, Politics & Social Sciences, Religion & Spirituality, Romance, Science Fiction, Self, Thriller, Travel, True Crime, Young Adult (YA) (13)",
                  game_sub_categories: "Action RPG, Action-adventure, Adventure Games, Arcade game, Battle Royale, Beat em up , Deck-building, Digital tabletop, Erotic, Fighting , Horror, immersive Sim, jrpg, MMORPG, Music, Party, Platformer, Puzzle, Roguelike,, Sandbox RPG, shooter, Simulation, Sports and Racing, stealth , Strategy, Strategy Games, survival, Text Adventures, Vehicle simulation, Visual novel",
                  cuisine_sub_categories: "Afghan, African, Senegalese, American, Andalusian, Arabic, Argentine, Armenian, Asian Fusion, Australian, Austrian, Bangladeshi, Barbeque, Bakery, Coffee Shop, Bavarian, Beer Garden, Belgian, Brazilian, Breakfast & Brunch, British, Bulgarian, Burmese, Cambodian, Caribbean, Dominican, Haitian, Puerto Rican, Trinidadian, Chinese, Cuban, Czech, Delis, Diners, Filipino, French, Gastropubs, Georgian, German, Greek, Halal, Hawaiian, Himalayan/Nepalese, Honduran, Hungarian, Iberian, Indian, Indonesian, Irish, Israeli, Italian, Japanese, Kosher, Laos, Latin American, Malaysian, Mediterranean, Mexican, Egyptian, Lebanese, Mongolian, Moroccan, New Zealand, Nicaraguan, Pakistani, Persian/Iranian, Peruvian, Pizza, Polish, Portuguese, Romanian, Russian, Scandinavian, Seafood, Singaporean, Slovakian, Somali, Soul Food, Southern, Spanish, Sri Lankan, Steakhouses, Sushi, Swedish, Swiss Food, Syrian, Taiwanese, Thai, Turkish, Ukrainian, Vegan, Vegetarian, Vietnamese, Yugoslav" }

sub_categorys.each_with_index do |(key, sub_category), index|
  sub_category.split(',').each do |sub_category|
    SubCategory.create(category_id: index + 1, name: sub_category.strip)
  end
end