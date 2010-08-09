# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery :only => [:create, :update, :destroy] # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
 
  def require_authorization
    @login_user ||=User.find(session[:user_id]) 
    return @login_user
  end
  
  def get_user
    @user = User.find session[:user_id]
  end

end
