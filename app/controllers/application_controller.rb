class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    #before_action :ensure_logged_in
  
    include SessionsHelper
   
    def ensure_logged_in
        unless logged_in?
        #flash[:notice] = 'Please log in.'
        redirect_to root_path
        end
    end
    
    def convertUnit(unit)
      if unit == 'tablespoon'
        'tbs'
      else
        unit
      end
    end
end