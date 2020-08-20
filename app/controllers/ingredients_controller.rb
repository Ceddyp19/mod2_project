class IngredientsController < ApplicationController
    accepts_nested_attributes_for :items
    def index
    end
end
