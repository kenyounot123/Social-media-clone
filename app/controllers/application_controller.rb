class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Redirect to profile creation after logging in
  def after_sign_in_path_for(resource)
    if current_user.name.nil? || current_user.name.empty?
      edit_user_path(current_user)
    else
      dashboard_path
    end
  end
end
