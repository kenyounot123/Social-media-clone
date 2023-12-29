class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  # Redirect to profile creation after logging in
  def after_sign_in_path_for(resource)
    if no_username?(current_user)
      edit_user_path(current_user)
    else
      dashboard_path
    end
  end

  private 
  
  def no_username?(user)
    user.name.nil? || user.name.empty?
  end

end
