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
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = Recipe.find(params[:id])
        if params[:add_ingredient]
            unless params[:recipe][:ingredients_arrtibutes].blank?
                for attribute in params[:recipe][:ingredients_attributes]
                    @recipe.ingredients.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
                end
            end
            @recipe.ingredients.build
        elsif params[:remove_ingredient]
            #byebug
            removed_ingredients = []
            recipe_params[:ingredients_attributes].each { |i, att| removed_ingredients << att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
            Ingredient.delete(removed_ingredients)
            flash[:notice] = "Ingredients removed."
            for attribute in params[:recipe][:ingredients_attributes]
                @recipe.ingredients.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
            end
        else
            if @recipe.update_attributes(recipe_params)
                flash[:notice] = "Successfully updated recipe."
                return redirect_to recipe_path(@recipe)
            end
        end
        render :edit       
    end
###############################Copied code below#########
# def update
#     @recipe = Recipe.find(params[:id])
#     if params[:add_ingredient]
#     	# rebuild the ingredient attributes that doesn't have an id
#     	unless params[:recipe][:ingredients_attributes].blank?
# 	  for attribute in params[:recipe][:ingredients_attributes]
# 	    @recipe.ingredients.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
# 	  end
#     	end
#       # add one more empty ingredient attribute
#       @recipe.ingredients.build
#     elsif params[:remove_ingredient]
#       # collect all marked for delete ingredient ids
#       removed_ingredients = params[:recipe][:ingredients_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
#       # physically delete the ingredients from database
#       Ingredient.delete(removed_ingredients)
#       flash[:notice] = "Ingredients removed."
#       for attribute in params[:recipe][:ingredients_attributes]
#       	# rebuild ingredients attributes that doesn't have an id and its _destroy attribute is not 1
# #         @recipe.ingredients.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
#       end
#     else
#       # save goes like usual
#       if @recipe.update_attributes(params[:recipe])
#         flash[:notice] = "Successfully updated recipe."
#         redirect_to @recipe and return
#       end
#     end
#     render :action => 'edit'
#   end  
######################################
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
            :id,
            :_destroy
          ])
     end

     def get_recipe
        @recipe = Recipe.find(params[:id])
     end
end




