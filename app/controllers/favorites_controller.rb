class FavoritesController < ApplicationController
  before_action :set_recipe
  def create
    faves = []
    current_user.favorites.each do |fav|
      faves << fav.recipe
    end
    #byebug
    if faves.include? @recipe
      redirect_to recipe_path(@recipe), notice: 'recipe already favorited!' #and return
    else
      Favorite.create(recipe: @recipe, user: current_user)

      redirect_to '/user_home' #notice: 'recipe has been favorited' #and return
    end
    
    
      
    # end
    # if current_user.favorites.include?(@recipe)
    #   redirect_to '/user_home', notice: 'recipe already favorited!'
    # else
    #   Favorite.create(recipe: @recipe, user: current_user)
    # #byebug
    #   redirect_to '/user_home', notice: 'recipe has been favorited'
    # end
    # else
    #   redirect_to '/user_home', alert: 'Something went wrong...*sad panda*'
    # end
  end

  def destroy
    Favorite.where(recipe_id: @recipe.id, user_id: current_user.id).first.destroy
    redirect_to '/user_home', notice: 'Recipe is no longer in favorites'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
