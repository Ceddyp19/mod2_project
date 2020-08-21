class Ingredient < ApplicationRecord
    has_many :items
    has_many :recipes, through: :items
    validates :name, uniqueness: true
    before_validation :uppercase_name

    def uppercase_name
      name.upcase!
    end

    def self.all_rice_dishes
        self.all.collect do |ing|
            if ing.id == self.find_by(name: 'Rice').id
                ing.name
            end
        end.compact
        # rice = self.all.find_by(name: 'Rice')
        # rice.recipes.each do |r|
        #     r.name 
        # end
    end

    def self.all_chicken_dishes
        chicken = self.all.find_by(name: 'Chicken')
        chicken.recipes.each do |c|
            c.name 
        end
    end

    def self.all_pasta_dishes
        pasta = self.all.find_by(name: 'Pasta')
        pasta.recipes.each do |p|
            p.name 
        end
    end
end
