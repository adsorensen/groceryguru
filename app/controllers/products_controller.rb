class ProductsController < ApplicationController
  # before_action :set_user, only: [:done]
  def done
    puts("Received Done")
    puts(params.to_s)
  end
  
  private 
  def auth
  
  end
end
