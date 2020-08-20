class Ingredient < ApplicationRecord
    has_many :items
    has_many :recipes, through: :items
    accepts_nested_attributes_for :items, allow_destroy: true
    validates :name, uniqueness: true
end
