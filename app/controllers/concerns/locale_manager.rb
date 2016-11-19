module LocaleManager
  extend ActiveSupport::Concern

  included do
    before_action :set_locale!
  end

  private

  def set_locale!
    case locale_strategy
    when :keep then return
    when :apply_param then set_locale_with(locale_param)
    when :apply_cookie then set_locale_with(locale_cookie)
    when :apply_default then set_locale_with(I18n.default_locale)
    else fail NotImplementedError
    end
  end
  
  def set_locale_with(locale)
    I18n.locale = locale.to_sym
    cookies.permanent[:current_locale] = locale
  end
  
  def locale_cookie
    @locale_cookie ||= cookies[:current_locale]
  end
  
  def locale_param
    @locale_param ||= String(params[:locale]).tap(&:strip!)
  end
  
  def valid_locale?(locale)
    I18n.available_locales.include?(locale.to_sym)
  end
  
  def current_locale?(locale)
    I18n.locale == locale.to_sym
  end
  
  def locale_strategy
    if locale_param.present?
      return :keep if locale_param == locale_cookie && current_locale?(locale_param)
      
      valid_locale?(locale_param) && !current_locale?(locale_param) ? :apply_param : :apply_default
    else
      return :apply_default if locale_cookie.blank?
      return :keep if current_locale?(locale_cookie)
      
      valid_locale?(locale_cookie) ? :apply_cookie : :apply_default
    end
  end
end
