class ListController < ApplicationController
  def new
  end

  def create
  end
  
  def create_list
    recipe_ids = Cart.where(user: session['user_id']).order(created_at: :desc)
    #render 'list/create', :locals => {:resource => recipe_ids}
    @ingredients = []
    st = ""
    for id_val in recipe_ids do
      recipe = Recipe.where(id: id_val.recipe).first
      instr = recipe.instructions
      for i in instr do
        @ingredients.append(Ingredient.find(i.ingredient_id).name.to_s)
      end
       
    end
    @ingredients = @ingredients.uniq
    render 'list/create', :locals => {:resource => @ingredients}
    #render :text => st
  end
  
  def checkout
    @chosen_ingredients = params[:names]
    index = 0
    @walmart_url = "https://grocery.walmart.com/products?query=" + @chosen_ingredients[index].gsub(' ','+')
  end
  
  def checkout_get
    @chosen_ingredients = params[:names]
    index = 0
    @walmart_url = "https://grocery.walmart.com/products?query=" + @chosen_ingredients[index].gsub(' ','+')
  end
end
