class CartController < ApplicationController
  def index
    @recipes = Recipe.all
  end
end
