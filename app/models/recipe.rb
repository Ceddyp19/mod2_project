class Recipe < ApplicationRecord
    belongs_to :style
    has_many :recipes_users
    has_many :users, through: :recipes_users
    has_many :items
    has_many :ingredients, through: :items
    accepts_nested_attributes_for :ingredients, :allow_destroy => true
    #accepts_nested_attributes_for :items
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
    
 
end

