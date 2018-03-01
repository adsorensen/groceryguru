class ProductsController < ApplicationController
  # before_action :auth, only: [:done]
  skip_before_action :verify_authenticity_token
  def done
    puts("*********** Received Done ******************")
    puts("User" + params['userId'] + "'s job is done. Status:" + params['status'])
  end
  
  private 
  def auth
  
  end
end
