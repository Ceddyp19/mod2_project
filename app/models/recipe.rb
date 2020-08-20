class Recipe < ApplicationRecord
    belongs_to :style
    has_many :recipes_users
    has_many :users, through: :recipes_users
    has_many :items
    has_many :ingredients, through: :items
    accepts_nested_attributes_for :ingredients, :allow_destroy => true
    accepts_nested_attributes_for :items
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :style, presence: true 
    validates :prep_time, presence:true
    validates :description, length: {minimum: 20}
    validates_associated :ingredients

    def ingredients_attributes=(ingredient_attributes)
        ingredient_attributes.values.each do |ingredient_attribute|
            ing = Ingredient.find_or_create_by(name: ingredient_attribute["name"], category: ingredient_attribute["category"])
            self.ingredients << ing unless self.ingredients.include?(ing)
            ingredient_attribute[:items_attributes].values.each do |item_attribute|
                #byebug
                if self.items.any?  do |item|
                    item.recipe_id == self.id 
                end
                item = self.items.select {|i| i.ingredient.id == ing.id && i.recipe.id == self.id}
                nu_item = item.first
                nu_item.quantity = item_attribute
                nu_item.save
            end
        end
    end
    
    # def ingredients_attributes=(ingredient_attributes)

    #     ingredient_attributes.values.each do |ingredient_attribute|
    #       #byebug
    #       if ingredient_attribute[:_destroy] == '1'
    #         ingredient = Ingredient.find_or_create_by(name: ingredient_attribute['name'])
    #         ingredient.delete
    #       else
    #         ingredient = Ingredient.find_or_create_by(name: ingredient_attribute['name'])
    #         self.ingredients << ingredient unless self.ingredients.include?(ingredient)
    #       end
    #       ingredient_attribute[:items_attributes].values.each do |item_attribute|
    #         #byebug
    #         if self.items.any? do |item|
    #             item.recipe_id == self.id && item.ingredient_id == ingredient.id
    #           end
    #           item = self.items.select do |i|
    #             i.ingredient_id == ingredient.id && i.recipe_id == self.id
    #           end.first
    #           item.quantity = item_attribute unless item_attribute.blank?
    #           item.save
    #         else
    #           item = self.items.select {|i| i.ingredient_id == ingredient.id}.first
    #           item.quantity = item_attribute unless item_attribute.blank?
    #           item.save
    #         end
    #       end
    #     end
    
    # end


    # def average_calories
    # end

    # def average_rating
    # end

    # def average_prep_time
    # end

    # def total_recipes
    # end

    # def total_dish_styles
    # end

    # def all_vegan_dishes
    # end

    # def count_favorited
    # end

    # def total_number_of_users
    # end

    # def recipe_creator
    # end

    # def most_favorited_style
    # end


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

end
