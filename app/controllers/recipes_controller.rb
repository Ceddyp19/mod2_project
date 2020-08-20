class RecipesController < ApplicationController
    before_action :get_recipe, only: [:show, :edit, :update, :destroy ]
    before_action :require_login

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
        @user = current_user
        #byebug
        @recipe = Recipe.new(recipe_params)
        if params[:add_ingredient]
        # add empty ingredient associated with @recipe
        @recipe.ingredients.build
        elsif params[:remove_ingredient]
        # nested model that have _destroy attribute = 1 automatically deleted by rails
    
        else
            if @recipe.valid?
                #byebug
                @recipe.save
                @user.recipes << @recipe
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
            #for attribute in params[:recipe][:ingredients_attributes]
             #   @recipe.ingredients.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
            #end
        else
            if @recipe.valid? 
                @recipe.update_attributes(recipe_params)
                flash[:notice] = "Successfully updated recipe."
                #byebug
                return redirect_to recipe_path(@recipe)
            end
        end
        render :edit       
    end

    def show
    end 

    def destroy 
        @recipe.items.destroy_all
        @recipe.destroy
        flash[:notice] = "Successfully deleted recipe."
        redirect_to recipes_path 
    end

    private
    
     def recipe_params
        params.require(:recipe).permit(
            :id, 
            :name, 
            :calories, 
            :description, 
            :prep_time, 
            :style_id, 
            :type, 
            :add_ingredient, 
            :remove_ingredient, 
            ingredients_attributes: [
            :name,
            :category,
            :id,
            :_destroy,
            items_attributes: [:id, :quantity, :recipe_id, :ingredient_id, :_destroy]])
     end

     def get_recipe
        @recipe = Recipe.find(params[:id])
     end

     
end




