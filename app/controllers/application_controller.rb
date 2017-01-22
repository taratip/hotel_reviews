class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # rescue_from ActiveRecord::RecordNotFound, :with => :rescue_action_in_public
  #
  # private
  #
  # # handles 404 when a record is not found.
  # def rescue_action_in_public(exception)
  #   case exception
  #   when ActiveRecord::RecordNotFound, ActionController::UnknownAction, ActionController::RoutingError
  #     binding.pry
  #     render :file => "#{RAILS_ROOT}/public/404.html", :layout => 'layouts/application', :status => 404
  #   else
  #     super
  #   end
  # end
end
