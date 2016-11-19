module RecipesHelper
  def human_attribute(name)
    Recipe.human_attribute_name(name)
  end
end
