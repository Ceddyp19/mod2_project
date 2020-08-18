class RecipesController < ApplicationController
    
    def index
    end 

    def new
        @recipe = Recipe.new
        @recipe.ingredients.build
    end

    def create
        @recipe = Recipe.new(recipe_params)
        #byebug
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end

    # if recipe_params[:add_ingredient]
    #     @recipe.ingredients.build
    # else
    #     if @recipe.save
    #         redirect_to recipe_path(@recipe)
    #     else
    #         render :new
    #     end
    # end

    # def create
    #     @recipe = Recipe.new(params[:recipe])
    #     if recipe_params[:add_ingredient]
    #       # add empty ingredient associated with @recipe
    #       @recipe.ingredients.build
    #     elsif params[:remove_ingredient]
    #       # nested model that have _destroy attribute = 1 automatically deleted by rails
    #     else
    #       # save goes like usual
    #       if @recipe.save
    #         flash[:notice] = "Successfully created recipe."
    #         redirect_to @recipe and return
    #       end
    #     end

    def update
    end

    private
    
     def recipe_params
        params.require(:recipe).permit(:name, :description, :prep_time, :style_id, :add_ingredient, ingredients_attributes: [
            :name,
            :category
          ])
     end
end
