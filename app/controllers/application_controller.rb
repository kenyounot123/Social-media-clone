class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # def after_sign_in_path_for(resource)
  #   case resource.class
  #   when User
  #     create_profile_path(current_user)
  #   end
  # end
end
