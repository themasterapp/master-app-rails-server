module Home
  class Params
    LATEST_FILTER = 'latest'.freeze
    MY_RECIPES_FILTER = 'my'.freeze
    
    attr_reader :params
    
    alias_method :raw, :params
    
    def initialize(params)
      @params = params
    end
    
    def search
      @search ||= params.permit(search: [:filter, :q])[:search] || {}
    end
    
    def search?
      search.present?
    end
    
    def to_search
      {search: {filter: MY_RECIPES_FILTER}}
    end
    
    def fetch_search(name, default = nil)
      return default unless search?
      
      search[name] || default
    end
    
    def current_filter
      @current_filter ||= fetch_search(:filter, LATEST_FILTER)
    end
    
    def current_filter?(filter)
      current_filter == String(filter)
    end
    
    def my_recipes_filter?
      current_filter == MY_RECIPES_FILTER
    end
    
    def build_filter_page_name(name)
      "#{name}_filter_page"
    end
    
    def current_filter_page_name
      @current_filter_page_name ||= build_filter_page_name(current_filter)
    end
    
    def current_filter_page_param
      params[current_filter_page_name]
    end
    
    def to_recipes_filter(filter)
      link_params = fetch_filter_page_params
      link_params[:search] = search.merge({filter: filter}).to_h
      link_params
    end
    
    private
    
    def fetch_filter_page_params
      @filter_pages ||= params.permit(
        build_filter_page_name(LATEST_FILTER),
        build_filter_page_name(MY_RECIPES_FILTER)
      ).to_h
    end
  end
end
