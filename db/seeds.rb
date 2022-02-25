puts "Cleaning the DB 💣💣💣"
Restaurant.destroy_all

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

puts "Seed completed! Have fun"