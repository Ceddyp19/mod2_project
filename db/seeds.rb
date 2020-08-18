# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Recipe.create(name:'Krabby Patty Formula', calories: 500, prep_time: '35 min.' description:'The best burgers in all of Bikini Bottom! Chum Bucket is trash..' )
Recipe.create(name:'Spasagna', calories: 1200, prep_time: '1.5 hours' description:'The best of both worlds!!' )
Recipe.create(name:'Fried Rice', calories: 345, prep_time: '40 min' description:'A China town classic' )


Ingredient.create(name: "Ground Krabs", category: "Seafood")
Ingredient.create(name: "Tomato", category: "Fruit")
Ingredient.create(name: "Rice", category: "Grain")

a = %w(African American Bakery Barbeque Brunch Cajun Chinese Cuban Dessert Ethiopian Fast Food German Greek Halal Hawaiian Indian Italian Jamaican Japanese Korean Kosher Latin American Lebanese Mediterranean Mexican Mongolian Moroccan Peruvian Polish Seafood Southern Southwestern Spanish Thai Vegan Vegetarian Vietnamese)
a.each do |s|
    Style.create(name: s)
end
# recipe:
# t.string "name"
#     t.integer "calories"
#     t.string "prep_time"
#     t.text "description"
#     t.string "style"

#     t.string "name"
#     t.string "category"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#   end

#   create_table "items", force: :cascade do |t|
#     t.string "quantity"
#     t.integer "recipe_id"
#     t.integer "ingredient_id"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#   end

