class Recipe < ApplicationRecord
    belongs_to :style
    has_many :items
    has_many :ingredients, through: :items
    accepts_nested_attributes_for :ingredients, :allow_destroy => true

    # def ingredients_attributes=(ingredient_attributes)
    #     ingredient_attributes.values.each do |ingredient_attribute|
    #               ingredient = Ingredient.find_or_create_by(ingredient_attribute)
    #               self.ingredients << ingredient
    #     end
    # end

    # def self.list_styles
    #     styles = %w(African American Bakery Barbeque Brunch Cajun Chinese Cuban Dessert Ethiopian Fast Food German Greek Halal Hawaiian Indian Italian Jamaican Japanese Korean Kosher Latin American Lebanese Mediterranean Mexican Mongolian Moroccan Peruvian Polish Seafood Southern Southwestern Spanish Thai Vegan Vegetarian Vietnamese)
    #     styles
    # end

    # def self.collect_style
    #     @@styles = []
    #     self.all.each do |recipe|
    #         @@styles << recipe.style 
    #     end
    #     @@styles 
    # end
end
