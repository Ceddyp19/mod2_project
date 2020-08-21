# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
30 times do 
Recipe.create(name:Faker::Food.unique.dish, calories: rand(15..2000), prep_time: "#{rand(5..120)} min", description: Faker::Food.unique.description, style_id:rand(15..39), rating:rand(1..10)  )
end

50 times do 
Ingredient.create(name: Faker::Food.unique.ingredient)
end 


a = %w(African American Bakery Barbeque Brunch Cajun Chinese Cuban Dessert Ethiopian Fast Food German Greek Halal Hawaiian Indian Italian Jamaican Japanese Korean Kosher Latin American Lebanese Mediterranean Mexican Mongolian Moroccan Peruvian Polish Seafood Southern Southwestern Spanish Thai Vegan Vegetarian Vietnamese)
a.each do |s|
    Style.create(name: s)
end

20 times do
    s = Style.find(rand(1..39))
    s.recipes << Recipe.find(rand(1..30))
end

100 times do
    r = Recipe.find(rand(1..30))
    r.ingredients << Ingredient.find(rand(1..50))
end
