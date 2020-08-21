class Recipe < ApplicationRecord
    belongs_to :style
    has_and_belongs_to_many :users
    has_many :items
    has_many :ingredients, through: :items
    accepts_nested_attributes_for :ingredients, :allow_destroy => true
    
    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: true }
    validates :style, presence: { case_sensitive: true }
    validates :prep_time, presence:true
    # validates :prep_time, inclusion: {in: %w( min ), message: "Prep time must be in specified in minutes (min)" }
    validates :description, length: {minimum: 20}
    validates :rating, numericality: { only_integer: true }
    validates_numericality_of :rating, less_than_or_equal_to: 10
    before_validation :uppercase_name

    def uppercase_name
      name.upcase!
    end

    def self.average_calories
        cal =   self.all.collect do |recipe|
                    recipe.calories
                end
                
        tc = cal.sum 
        tr = Recipe.all.count
        ans = (tc / tr)
        ans
    end

    def self.average_rating
        rat = self.all.collect do |recipe|
                recipe.rating
              end
        
        ar = rat.sum 
        tr = Recipe.all.count
        ans = (ar / tr)
        ans
    end

    def self.average_prep_time
        prep = self.all.collect do |recipe|
                    recipe.prep_time.split('min')
                end
                #prep looks like: [["35 "], ["90 "], ["40 "]] 
        prep = prep.join.split
               #now prep looks like: ["35", "90", "40"] 

        prep.sum { |n| n.to_i } # turns each number to string then adds them together 
    end

    def self.all_recipes
        self.all.count 
    end


    def self.all_vegan_dishes
        self.all.collect do |dish|
            if dish.style_id == Style.where(name: 'Vegan').ids
                dish.name
            end
        end.compact
    end

    def self.all_vegetarian_dishes
        self.all.collect do |dish|
            if dish.style_id == Style.where(name: 'Vegetarian').ids
                dish.name
            end
        end.compact
    end

    def total_number_of_users
    end

    def recipe_creator
    end

    def most_favorited_style
    end


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
