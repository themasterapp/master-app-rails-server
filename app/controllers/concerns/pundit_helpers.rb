module PunditHelpers
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t("auth.access_denied")

    redirect_back_with_default_fallback turbolinks: :advance
  end
end
