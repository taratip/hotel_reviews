class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorize_admin!
    if current_user.nil? or !current_user.admin?
      flash[:notice] = "You are not authorized to view this resource."
      redirect_to root_path
    end
  end

  def authenticate_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end
