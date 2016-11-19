class RecipesController < ApplicationController
  before_action :authenticate_user!, except: :show
  
  before_action :set_recipe, except: [:new, :create]
  
  after_action :verify_authorized
    
  def show
    set_meta_tags(title: @recipe.title, description: @recipe.story)
  end
  
  def new
    @recipe = build_recipe
    
    authorize @recipe
  end

  def create
    @recipe = build_recipe(recipe_params)

    authorize @recipe

    if @recipe.save
      redirect_to @recipe, notice: t(".notice"), turbolinks: :advance
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render :save }
      end
    end
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: t(".notice"), turbolinks: :advance
    else
      respond_to do |format|
        format.html { render :edit }
        format.js { render :save }
      end
    end
  end
  
  def destroy
    @recipe.destroy
    
    back_to = params[:back_to] || root_path

    redirect_to back_to, notice: t(".notice"), turbolinks: :replace
  end
  
  private
  
  def build_recipe(params={})
    current_user.recipes.build(params)
  end
  
  def set_recipe
    @recipe = Recipe.friendly.find(params[:id])
    
    authorize @recipe
  end
  
  def recipe_params
    params.require(:recipe).permit(:title, :story, :ingredients, :instructions)
  end
end
