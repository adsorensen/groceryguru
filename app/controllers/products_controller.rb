class ProductsController < ApplicationController
  before_action :set_user, only: [:done]
  def done
  end
  
  private 
  def auth
  
  end
end
