class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    #before_action :ensure_logged_in
  
    include SessionsHelper
   
    def index
      if logged_in?
          redirect_to '/users/' + session[:user_id].to_s
      else
        redirect_to root_path
      end
    end
    
    private
    
    def process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
        r.base_uri.to_s
      end
    end
end