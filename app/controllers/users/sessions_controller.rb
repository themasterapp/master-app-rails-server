class Users::SessionsController < Devise::SessionsController
  include MetaTagsHelpers
  include TurbolinksHelpers

  respond_to :html, :js

  before_action :verify_destroy_request, only: :destroy
  skip_before_action :verify_authenticity_token, if: :js_request?

  # https://github.com/plataformatec/devise/blob/v4.2.0/app/controllers/devise/sessions_controller.rb#L73
  def respond_to_on_destroy
    respond_to do |format|
      format.js { redirect_after_sign_out turbolinks: :advance }
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_after_sign_out }
    end
  end

  private

  def js_request?
    request.format.js?
  end

  def verify_destroy_request
    # Ensure that the sing_out via get works only when
    # the is request has the Turbolinks User Agent
    if !request.delete? && !turbolinks_app?
      raise AbstractController::ActionNotFound
    end
  end

  def redirect_after_sign_out(turbolinks: false)
    redirect_to(after_sign_out_path_for(resource_name), turbolinks: turbolinks)
  end
end
