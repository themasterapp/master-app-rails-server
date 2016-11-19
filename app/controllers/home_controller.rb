class HomeController < ApplicationController
  def index
    set_meta_tags(title: t(".titles.#{home_params.current_filter}"))
    
    @recipes = if guest_in_my_recipes_filter?
                 Recipe.none
               else
                 find_all_recipes(relation_base)
               end
  end
  
  private
  
  def guest_in_my_recipes_filter?
    !user_signed_in? && home_params.my_recipes_filter?
  end
  
  def relation_base
    base = Recipe.joins(:user).includes(:user)
    
    return base if user_signed_in? && current_user.admin?
    
    user_ids = User.admin.pluck(:id)
    
    user_ids << current_user.id if user_signed_in?
    
    base.where('recipes.user_id'.freeze => user_ids)
  end
  
  def find_all_recipes(relation)
    if home_params.search?
      relation = apply_user_filter(relation)
      relation = apply_query_filter(relation)
    end
    
    apply_pagination relation.order(created_at: :desc)
  end
  
  def apply_user_filter(relation)
    return relation if !user_signed_in?
    
    if home_params.my_recipes_filter?
      relation.where(user_id: current_user.id)
    else
      relation
    end
  end
  
  def apply_query_filter(relation)
    q = params.dig(:search, :q)
    
    return relation if q.blank?
    
    query = "%#{q}%"

    relation.where('recipes.title ILIKE ?'.freeze, query)
            .or(relation.where('recipes.story ILIKE ?'.freeze, query))
            .or(relation.where('recipes.ingredients ILIKE ?'.freeze, query))
            .or(relation.where('users.name ILIKE ?'.freeze, query))
  end
  
  def apply_pagination(relation)
    relation.page home_params.current_filter_page_param
  end
end
