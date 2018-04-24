require 'ostruct'

class CartController < ApplicationController
  # before_action :set_cart, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  
  def add_item
    ingr = params['ingr']
    item = Ingredient.find_by_name(ingr)
    if item.nil?
      sp = Ingredient.find_by_name("special")
      newValue = CheckoutList.new(:user_id => session['user_id'], :ingredient_id => sp.id, :quantity => 1, :ingr_name => ingr)
      # @ingredientIds.append(sp.id)
      newValue.save
    else
      newValue = CheckoutList.new(:user_id => session['user_id'], :ingredient_id => item.id, :quantity => 1)
      # @ingredientIds.append(item.id)
      newValue.save
    end
    
    respond_to do |format|
      format.html { render :new }
    end
  end
  
  def remove_item
    ingr = params['ingr']
    row = CheckoutList.where(user_id: session['user_id'], ingr_name: ingr)
    for r in row do
      r.destroy
    end
    respond_to do |format|
      format.html { render :new }
    end
  end
  
  # function converts differnent units to ounces
  def convert_to_oz(amount, unit)
    conversions = {"TABLESPOON" => 0.5, "TBSP" => 0.5, "TEASPOON" => 0.16667, 
      "TSP" => 0.16667, "CUP" => 8, "HANDFUL" => 4, "OUNCE" => 1, "PINCH" =>
      0.013, "SERVING" => 4, "POUND" => 16, "LBS" => 16, "CLOVE" => 0.16667,
      "HEAD" => 32, "OZ" => 1, "C" => 8, "BUNCH" => 8, "PIECE" => 4, "G" =>
      0.03527, "TBS" => 0.5, "SLICES" => 6, "CAN" => 1, "DASHES" => 0.03125,
      "SPRIG" => 0.03125, "PINCHES" => 0.013, "DASH" => 0.03125, "PINT" => 16,
      "TB" => 0.5, "KG" => 35.274, "ML" => 0.03381, "" => 1
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
      newA = amount
    end
    
    return newA, noUnit
  end
  
  def index
    # get recipes in user's cart
    @userId = session['user_id']
    recipe_ids = Cart.where(user: session['user_id']).order(created_at: :desc)
    recipes = Array.new
    for id_val in recipe_ids do
      recipeCart = OpenStruct.new
      recipeCart.recipe = Recipe.where(id: id_val.recipe)
      recipeCart.cart = Cart.where(user: session['user_id'], recipe: recipeCart.recipe).first
      recipes << recipeCart
    end
   @recipes_list = recipes
   @cart = Cart.all
   
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
    
    @ingredientIds = []
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
          newValue = CheckoutList.new(:user_id => session['user_id'], :ingredient_id => i.ingredient_id, :quantity => 1, :ingr_name => food.name)
          @ingredientIds.append(i.ingredient_id)
          newValue.save
        else
          valueToUpdate = CheckoutList.where(ingredient_id: i.ingredient_id)
          valueToUpdate.first.quantity = valueToUpdate.first.quantity + 1
          valueToUpdate.first.save
        end
        
      end
       
    end
    @ingredients = @ingredients.uniq
  end
  
  def show
  end
  
  def new
    @cart = Cart.new
  end
  
  def edit
  end
  
  def create
    if params[:user].present? 
          @cart = Cart.new(cart_params)
    else
      @cart = Cart.new(:user => session["user_id"], :recipe => params[:recipe])
    end
    
  
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart}
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Prep note was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @prep_note.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @cart.destroy
    respond_to do |format|
      # format.html { redirect_to '/cart', notice: 'Cart was successfully destroyed.' }
      format.html { redirect_to '/cart'}
      format.json { head :no_content }
    end
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
    @walmart_url = "https://www.smithsfoodanddrug.com/search?query=" + @chosen_ingredients[index].gsub(' ','%20')
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
      @walmart_url = "https://www.smithsfoodanddrug.com/search?query=" + ingredients[index].gsub(' ','%20')
    else
      @walmart_url = "https://www.smithsfoodanddrug.com/shopping/cart"
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user, :recipe)
    end
end
