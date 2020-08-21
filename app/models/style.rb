class Style < ApplicationRecord
    has_many :recipes
    validates :name, uniqueness: true
    validates :name, presence: true
    before_validation :uppercase_name

    def uppercase_name
      name.upcase!
    end

    def self.total_dish_styles
        self.all.count
    end

    def self.favorite_dish_style 
    end 
end
