class Users::SettingsController < ApplicationController
  def change_locale
    locale = String(params[:locale]).tap(&:strip!)&.to_sym
    locale = I18n.default_locale unless I18n.available_locales.include?(locale)

    cookies.permanent[:current_locale] = locale

    redirect_back_with_default_fallback or: params[:back_to], turbolinks: :advance
  end
end
