class ListController < ApplicationController
  def new
  end

  def create
  end
  
  # function converts differnent units to ounces
  def convert_to_oz(amount, unit)
    conversions = {"TABLESPOON" => 0.5, "TBSP" => 0.5, "TEASPOON" => 0.16667, 
      "TSP" => 0.16667, "CUP" => 8, "HANDFUL" => 4, "OUNCE" => 1, "PINCH" =>
      0.013, "SERVING" => 4, "POUND" => 16, "LBS" => 16, "CLOVE" => 0.16667,
      "HEAD" => 32, "OZ" => 1, "C" => 8, "BUNCH" => 0, "PIECE" => 0, "G" =>
      0, "TBS" => 0.5, "SLICES" => 0, "CAN" => 0, "DASHES" => 0,
      "SPRIGS" => 0, "PINCHES" => 0, "DASH" => 0, "PINT" => 0, "TB" => 0.5,
      "KG" => 0, "SPRIG" => 0, "ML" => 0, "" => 1
    }
    noUnit = false
    if conversions.include? unit.upcase
      if unit == ""
        noUnit = true
      end
      v = conversions[unit.upcase]
      newA = amount * v
    elsif conversions.include? unit.upcase[0..-2]
      v = conversions[unit.upcase[0..-2]]
      newA = amount * v
    else
      newA = -100
    end
    
    # u = unit.upcase
    # case u
    # when "TABLESPOON", "TABLESPOONS", "TBSP"
    #   newA = amount / 2
    # when "TEASPOON", "TEASPOONS", "TSP"
    #   newA = amount * 0.16667
    # when "CUP", "CUPS", "C"
    #   newA = amount * 8
    # when "HANDFUL", "HANDFULS"
    #   newA = amount * 4
    # when "OZ", "OUNCE", "OUNCES"
    #   newA = amount
    # when "LBS", "POUND", "POUNDS"
    #   newA = amount * 16
    # when "PINCH", "PINCHES"
    #   newA = amount * 0.013
    # when "SERVINGS", "SERVING"
    #   newA = amount * 4
    # when ""
    #   newA = amount
    #   noUnit = true
    # when "CLOVE", "CLOVES"
    #   newA = amount * 0.16667
    # when "HEAD", "HEADS"
    #   newA = amount * 32
    # else
    #   newA = -100
    # end
    
    return newA, noUnit
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
    @ingredients2 = {}
    @blacklist = []
    
    ingredientIds = []
    for id_val in recipe_ids do
      recipe = Recipe.where(id: id_val.recipe).first
      instr = recipe.instructions
      for i in instr do
        food = Ingredient.find(i.ingredient_id)
        # get the amount from the instructions
        a = i.amount
        # get the unit
        u = i.unit
        # return the ounce amount and flag if there is no unit
        oa, noUnit = convert_to_oz(a, u)
        # if there is no unit for the item, add it to the blacklist
        if noUnit
          @blacklist.append(food.name)
        end
        
        
        
        @ingredients.append(Ingredient.find(i.ingredient_id))
        if @ingredients2[food] != nil
          @ingredients2[food] += oa
        else
          @ingredients2[food] = oa
        end
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
    #render :text => st
    #render 'list/create', :locals => {:resource => @ingredients2}
    render 'list/create'
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
