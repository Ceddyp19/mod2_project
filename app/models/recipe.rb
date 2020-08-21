class Recipe < ApplicationRecord
    belongs_to :style
    has_many :recipes_users
    has_many :users, through: :recipes_users
    has_many :favorites
    has_many :items
    has_many :ingredients, through: :items
    accepts_nested_attributes_for :ingredients, :allow_destroy => true
    
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :style, presence: true 
    validates :prep_time, presence:true
    validates :description, length: {minimum: 20}
    validates_associated :ingredients

    def ingredients_attributes=(ingredient_attributes)
        ingredient_attributes.values.each do |ingredient_attribute|
            if ingredient_attribute[:_destroy] == '1'
                ing = Ingredient.find_or_create_by(name: ingredient_attribute['name'], category: ingredient_attribute['category'])
                ing.delete
              else
                ing = Ingredient.find_or_create_by(name: ingredient_attribute['name'], category: ingredient_attribute['category'])
                self.ingredients << ing unless self.ingredients.include?(ing)
              end
            ingredient_attribute[:items_attributes].values.each do |item_attribute|
                #byebug
                if self.items.any?
                    self.items.each {|item| item.recipe_id == self.id && item.ingredient_id == ing.id}
                    item = self.items.select {|i| i.ingredient_id == ing.id && i.recipe_id == self.id}
                    nu_item = item.first
                    nu_item.quantity = item_attribute unless item_attribute.blank?
                    nu_item.save
                else
                    item = self.items.select {|i| i.ingredient_id == ing.id }
                    nu_item = item.first 
                    nu_item.quantity = item_attribute unless item_attribute.blank?
                    nu_item.save
                end
            end
        end
    end
    


    def self.average_calories
        cal =   self.all.collect do |recipe|
                    recipe.calories
                end
                
        tc = cal.sum 
        tr = Recipe.all.count

        ans = tc / total_recipes
        ans
    end

    def self.average_rating
    end

    def self.average_prep_time
        prep = self.all.collect do |recipe|
                    recipe.prep_time.split('min').to_i
                end
        # prep.keep_if {|n| n =~ /[0..9]/}
        byebug
        prep = prep.collect
        byebug
        prep = prep.split("min")
        byebug
        tpt = prep.sum
        ans = tpt / total_recipes

        # a.keep_if {|v| v =~ /[aeiou]/ }
    end

    def self.total_recipes
        self.all.count 
    end


    def all_vegan_dishes
    end

    def count_favorited
    end

    def total_number_of_users
    end

    def recipe_creator
    end

    def most_favorited_style
    end

end

