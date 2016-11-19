class Users::RegistrationsController < Devise::RegistrationsController
  include MetaTagsHelpers
  include DevisePermittedParameters

  respond_to :html, :js
end
