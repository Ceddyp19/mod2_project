class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :calories
      t.string :prep_time
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
