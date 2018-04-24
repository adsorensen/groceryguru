# Comment changed
class AboutController < ApplicationController
    skip_before_filter :verify_authenticity_token  
    
    def index
        render :layout => false
    end
    
    def create
        data = params[:body]
        name = params[:name]
        @email = params[:email]

        CustomerMailer.mailer(@email, name, data).deliver
        
        respond_to do |format| 
            format.html { render :nothing => true } 
        end    
    end
end
