puts "Cleaning the DB 💣💣💣"
Restaurant.destroy_all
Review.destroy_all

puts "Creating some restaurants"
Restaurant.create!(
  name: "Hong Kong Dim",
  address: "Mediapark" 
)

Restaurant.create!(
  name: "McDonalds",
  address: "Everywhere" 
)

Restaurant.create!(
  name: "Takumi",
  address: "Mediapark" 
)

Review.create!(
  restaurant: Restaurant.first, 
  comment: "very nice place! I love Hong Kong", 
  rating: 1
)

Review.create!(
  restaurant: Restaurant.second, 
  comment: "Is it cheap because its bad or is it bad because its cheap?", 
  rating: 1
)

Review.create!(
  restaurant: Restaurant.last, 
  comment: "👌👌👌👌👌👌👌👌👌👌👌👌👌👌👌", 
  rating: 5
)

puts "Seed completed! Have fun"