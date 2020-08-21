class Ingredient < ApplicationRecord
    has_many :items
    has_many :recipes, through: :items
    accepts_nested_attributes_for :items, allow_destroy: true
    #validates :name, uniqueness: true
    before_validation :uppercase_name

    def uppercase_name
      name.upcase!
    end

    def self.all_rice_dishes
        rice = self.all.find_by(name: "Rice")
        rice.recipes
    end

    def self.all_chicken_dishes
        chicken = self.all.find_by(name: "Chicken".upcase)
        chicken.recipes
    end

    def self.all_pasta_dishes
        pasta = self.all.find_by(name: 'Pasta'.upcase)
        pasta.recipes
    end
end
