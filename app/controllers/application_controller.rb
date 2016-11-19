class ApplicationController < ActionController::Base
  include LocaleManager
  include TurbolinksHelpers
  include TokenAuthentication
  include PunditHelpers
  include MetaTagsHelpers

  protect_from_forgery with: :exception

  before_action do
    # TODO: fix this logic. It depends on the order of the commands.
    request.variant = :msite if browser.device.mobile?
    request.variant = :app if turbolinks_app?
  end

  private

  # Mix of these two concepts:
  # http://blog.bigbinary.com/2016/02/29/rails-5-improves-redirect_to_back-with-redirect-back.html
  # https://github.com/rails/rails/blob/5-0-stable/actionpack/lib/action_controller/metal/redirecting.rb
  def redirect_back_with_default_fallback(**args)
    location = args.delete(:or)

    if location
      redirect_to location, **args
    else
      location = (request.referer || root_path)

      redirect_back(**args.merge!(fallback_location: location))
    end
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-Change-the-redirect-path-after-destroying-a-session-i.e.-signing-out
  def after_sign_out_path_for(resource_or_scope)
    turbolinks_ios_app? ? new_user_session_path : super
  end
  
  protected
  
  def home_params
    @home_params ||= Home::Params.new(params)
  end
  helper_method :home_params
end
