class CartController < ApplicationController
  def index
    @recipes = Recipe.all # set to pull from cart table for that user
  end
end
