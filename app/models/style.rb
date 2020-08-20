class Style < ApplicationRecord
    has_many :recipes

    def self.total_dish_styles
        self.all.count
    end

    def self.favorite_dish_style 
    end 
end
