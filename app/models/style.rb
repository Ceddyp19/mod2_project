class Style < ApplicationRecord
    has_many :recipes
    validates :name, uniqueness: true
    validates :name, presence: true

    def self.total_dish_styles
        self.all.count
    end

    def self.favorite_dish_style 
    end 
end
