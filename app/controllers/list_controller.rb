class ListController < ApplicationController
  def new
  end

  def create
  end
  
  def create_list
    # clear out checkout list to generate again
    current_list = CheckoutList.where(user_id: session['user_id'])
    for row in current_list do
      row.destroy
    end
    
    # create list based on cart
    recipe_ids = Cart.where(user: session['user_id']).order(created_at: :desc)
    @ingredients = []
    ingredientIds = []
    for id_val in recipe_ids do
      recipe = Recipe.where(id: id_val.recipe).first
      instr = recipe.instructions
      for i in instr do
        @ingredients.append(Ingredient.find(i.ingredient_id))
        if CheckoutList.where(ingredient_id: i.ingredient_id).blank?
          newValue = CheckoutList.new(:user_id => session['user_id'], :ingredient_id => i.ingredient_id, :quantity => 1)
          ingredientIds.append(i.ingredient_id)
          newValue.save
        else
          valueToUpdate = CheckoutList.where(ingredient_id: i.ingredient_id)
          valueToUpdate.first.quantity = valueToUpdate.first.quantity + 1
          valueToUpdate.first.save
        end
        
      end
       
    end
    @ingredients = @ingredients.uniq
    render 'list/create', :locals => {:resource => @ingredients}
  end
  
  def checkout
    ingredient_ids = params[:ingredient_ids]
    @chosen_ingredients = []
    
    @ingredient_in_list = CheckoutList.where(:user_id => session['user_id'])
    for ingredient in @ingredient_in_list do
      if !(ingredient_ids.include? ingredient.ingredient_id.to_s)
        CheckoutList.where(user_id: session['user_id']).where(ingredient_id: ingredient.ingredient_id).first.destroy
      end
    end
    
    for id in ingredient_ids do
      @chosen_ingredients.append(Ingredient.find(id).name)
    end
    index = params[:index].to_i
    @walmart_url = "https://grocery.walmart.com/products?query=" + @chosen_ingredients[index].gsub(' ','+')
  end
  
  def checkout_get
    @chosen_ingredients = CheckoutList.where(:user_id => session['user_id'])
    ingredients = []
    for ingredient in @chosen_ingredients do
      name = Ingredient.where(id: ingredient.ingredient_id).first.name
      ingredients.append(name)
    end
    index = params[:index].to_i
    @displayNext = index < ingredients.length
    @displayPrev = index > 0
    nextIndex = index + 1
    prevIndex = index - 1
    
    @relative_url_next = "/checkout?index=" + (nextIndex).to_s
    @relative_url_prev = "/checkout?index=" + (prevIndex).to_s
    
    if @displayNext 
      @walmart_url = "https://grocery.walmart.com/products?query=" + ingredients[index].gsub(' ','+')
    else
      @walmart_url = "https://grocery.walmart.com/checkout"
    end
  end
end
