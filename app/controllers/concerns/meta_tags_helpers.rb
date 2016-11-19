module MetaTagsHelpers
  extend ActiveSupport::Concern
  
  included do
    before_action :set_meta_tags_with_defaults
  end
  
  def set_meta_tags_with_defaults(data = {})
    defaults = title_meta_tag_data
                 .merge!(default_image_meta_tag_data)
                 .merge!(description_meta_tag_data)
    
    set_meta_tags defaults.merge!(data)
  end
  
  def description_meta_tag_data
    { description: I18n.t('app.meta.description'.freeze) }
  end
  
  def default_image_meta_tag_data
    { image_src: ENV.fetch('DEFAULT_RECIPE_IMAGE').freeze }
  end
  
  def title_meta_tag_data
    data = {}
    locales = I18n.t(:titles)
    default = locales[:application]
    controller = controller_name.to_sym
    
    data[:title] = locales.dig(controller, action_name.to_sym)
    data[:title] ||= locales[controller].instance_of?(String) ? locales[controller] : default
    
    if !turbolinks_app? && data[:title] != default
      data[:site] = default
    end
    
    data
  end
end
