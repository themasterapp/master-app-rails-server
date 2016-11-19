module HomeHelper
  def link_to_recipes_filter(filter)
    link_params = home_params.to_recipes_filter(filter)
    
    class_when_active = 'active'.freeze if home_params.current_filter?(filter)
    
    link_to t(".#{filter}"), root_path(link_params), {
      class: "btn btn-default #{class_when_active}",
      data: { 'turbolinks-action'.freeze => :replace }
    }
  end
  
  def has_recipes?
    return false if !user_signed_in?
    
    @count_user_recipes ||= current_user.recipes.count
    @count_user_recipes > 0
  end
  
  def no_recipes_message_component(text=nil)
    result = content_tag :p do
      content_tag :h3, class: 'text-center'.freeze do
        if block_given?
          yield
        else
          text
        end
      end
    end
    
    content_tag(:hr) + result
  end
end
