class AddStoryToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :story, :text
  end
end
