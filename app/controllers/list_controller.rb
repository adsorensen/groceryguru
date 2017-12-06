class ListController < ApplicationController
  def new
  end

  def create
  end
  
  def create_list
    recipe_ids = Cart.where(user: session['user_id']).order(created_at: :desc)
    #render 'list/create', :locals => {:resource => recipe_ids}
    @ingredients = []
    st = "blah"
    for id_val in recipe_ids do
      recipe = Recipe.where(id: id_val.recipe).first
      instr = recipe.instructions
      for i in instr do
        st += Ingredient.find(i.ingredient_id).name.to_s
      end
      #ing = 
    end
    render :text => st
  end
end
