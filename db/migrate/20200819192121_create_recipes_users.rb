class CreateRecipesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes_users do |t|
      t.integer :user_id
      t.integer :recipe_id
    end
  end
end
