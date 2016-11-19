# FIXME: Very weak strategy for a production App.
module TokenAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_from_token!
  end

  private

  def authenticate_user_from_token!
    return if user_signed_in?
    
    auth_token = params[:auth_token].presence
    user       = auth_token && User.find_by(authentication_token: String(auth_token))

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      # sign_in user, store: false
      sign_in user
    end
  end
end
