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
    validates :prep_time, inclusion: (in: %w(min), message: "Prep time must be in specified in minutes (min)" )
    validates :description, length: {minimum: 20}


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
                    recipe.prep_time.split('min')
                end
                #prep looks like: [["35 "], ["90 "], ["40 "]] 
        prep = prep.join.split
               #now prep looks like: ["35", "90", "40"] 

        prep.sum { |n| n.to_i } # turns each number to string then adds them together 
    end

    def self.total_recipes
        self.all.count 
    end


    def self.all_vegan_dishes
        self.all.collect do |dish|
            if dish.style_id == 37
                dish.name
            end
        end.compact
    end

    def self.all_vegetarian_dishes
        self.all.collect do |dish|
            if dish.style_id == 38
                dish.name
            end
        end.compact
    end

    def self.all_rice_dishes
        self.all.collect do |dish|
            if dish.style_id == 3
                dish.name
            end
        end.compact
        rice = Ingredient.find_by(name:'Rice')
        rice_dishes = Item.where(ingredient_id: 3) #return all rice dishes
    end

    def self.all_chicken_dishes
        self.all.collect do |dish|
            if dish.style_id == 
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
