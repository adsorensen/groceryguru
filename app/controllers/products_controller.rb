class ProductsController < ApplicationController
  # before_action :auth, only: [:done]
  skip_before_action :verify_authenticity_token
  def done
    puts("*********** Received Done ******************")
    puts("User" + params['userId'].to_s + "'s job is done. Status:" + params['status'].to_s)
    render 'products/done'
  end
  
  private 
  def auth
  
  end
end
