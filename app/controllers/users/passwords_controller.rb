class Users::PasswordsController < Devise::PasswordsController
  include MetaTagsHelpers
  
  respond_to :html, :js
end
