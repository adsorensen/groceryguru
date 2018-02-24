class ProductsController < ApplicationController
  # before_action :set_user, only: [:done]
  def done
    puts("Received Done")
  end
  
  private 
  def auth
  
  end
end
