module TurbolinksHelpers
  extend ActiveSupport::Concern

  TURBOLINKS_IOS_APP_USER_AGENT = ENV.fetch("TURBOLINKS_IOS_APP_USER_AGENT").freeze
  TURBOLINKS_ANDROID_APP_USER_AGENT = ENV.fetch("TURBOLINKS_ANDROID_APP_USER_AGENT").freeze

  def turbolinks_ios_app_user_agent?
    request.user_agent.include?(TURBOLINKS_IOS_APP_USER_AGENT)
  end

  def turbolinks_android_app_user_agent?
    request.user_agent.include?(TURBOLINKS_ANDROID_APP_USER_AGENT)
  end

  def turbolinks_app_user_agent?
    turbolinks_ios_app_user_agent? || turbolinks_android_app_user_agent?
  end
  
  included do
    [
      [:turbolinks_app?, :turbolinks_app_user_agent?],
      [:turbolinks_ios_app?, :turbolinks_ios_app_user_agent?],
      [:turbolinks_android_app?, :turbolinks_android_app_user_agent?]
    ].each do |alias_name, original_name|
      alias_method alias_name, original_name
      
      helper_method alias_name
      helper_method original_name
    end
  end
end
