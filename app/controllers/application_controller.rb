# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
   filter_parameter_logging :password
   
   protected
   
   #Check if the user can edit/create content
   def authorize
     if session[:user_id].nil? #Not logged in?
       flash[:error] = "You must log in to edit content!"
       redirect_to login_path
     end
   end
end
