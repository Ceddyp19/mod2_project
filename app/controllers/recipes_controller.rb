class RecipesController < ApplicationController
    before_action :get_recipe, only: [:show, :edit, :destroy ]

    def index
        @recipes = Recipe.all
    end 

    # def showexit
    # end

    def new
        @recipe = Recipe.new
        @recipe.ingredients.build
    end
####################Original
    # def create
    #     @recipe = Recipe.new(recipe_params)
    #     #byebug
    #     if @recipe.save
    #         redirect_to recipe_path(@recipe)
    #     else
    #         render :new
    #     end
    # end
#######################
    def create
        @recipe = Recipe.new(recipe_params)
        if params[:add_ingredient]
        # add empty ingredient associated with @recipe
        @recipe.ingredients.build
        elsif params[:remove_ingredient]
        # nested model that have _destroy attribute = 1 automatically deleted by rails
    
        else
            if @recipe.save
                flash[:notice] = "Successfully created recipe."
                return redirect_to recipe_path(@recipe) #and return
                #byebug 
            end
        end
        render :new
    end


    def edit
    end

    def update
    end

    def show
        #@recipe = Recipe.find(params[:id])
    end 

    def destroy 
        @recipe.destroy
        flash[:notice] = "Successfully destroyed recipe."
        redirect_to recipes_path 
    end

    private
    
     def recipe_params
        params.require(:recipe).permit(:name, :calories, :description, :prep_time, :style_id, :add_ingredient, :remove_ingredient, ingredients_attributes: [
            :name,
            :category,
            :_destroy
          ])
     end

     def get_recipe
        @recipe = Recipe.find(params[:id])
     end
end




