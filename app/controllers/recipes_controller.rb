class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
    @cart = Cart.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    #@recipe.instructions.build # build instruction attributes
  end

  # GET /recipes/1/edit
  def edit
  end
  
  # GET /recipes/text
  def text
    @recipe = Recipe.new
  end

  # POST /recipes
  # POST /recipes.json
  # original
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.private = params['private']
    
    # loop over ingredients from table
    count = 1
    while params.has_key?('ingredient' + count.to_s)
      quantity = params['quantity'+count.to_s]
      unit = params['unit'+count.to_s]
      ingredient = params['ingredient'+count.to_s]
      prep = params['prep'+count.to_s]
    
      # Add new ingredient if it doesn't exist
      @ingredient = Ingredient.where(name: ingredient).first
      if @ingredient.nil? 
        @ingredient = Ingredient.create name: ingredient
      end
      
      # Create corresponding instruction
      @instruction = Instruction.new ingredient_id: @ingredient.id, amount: quantity, unit: unit, prep_note: prep
      # Add associations
      @recipe.instructions << @instruction
      
      count += 1
    end
    
    if params['private'] 
      pri = true;
    else
      pri = false;
    end
    
    # Make saved recipe entry
    @saved_recipe = SavedRecipe.new user_id: session['user_id'], personal: true, private: pri
    @recipe.saved_recipes << @saved_recipe

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  # original
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    i = @recipe.id
    @instruction = Instruction.where(recipe_id: i).first
    while @instruction
      @instruction.destroy
      @instruction = Instruction.where(recipe_id: i).first
    end
    @saved_recipe = SavedRecipe.where(recipe_id: i).first
    while @saved_recipe
      @saved_recipe.destroy
      @saved_recipe = SavedRecipe.where(recipe_id: i).first
    end
    @cart = Cart.where(recipe: i).first
    while @cart
      @cart.destroy
      @cart = Cart.where(recipe: i).first
    end
    @recipe.reviews.all.each do |review|
      review.destroy
    end
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  def review
    uid = session["user_id"]
    @review = Review.create recipe_id: params['recipe_id'], user_id: uid, text: params['review'], rating: params['rating']
    
    @recipe = Recipe.find(params['recipe_id'])
    respond_to do |format|
      if @review.save
        format.html { redirect_to @recipe, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  def edit_review
    @review = Review.find(params['id'])
    newText = params['text']
    newRate = params['newRate']
    @recipe = Recipe.find(params['recipe_id'])
     
    respond_to do |format|
      if @review.update(text: newText, rating: newRate)
        format.html { redirect_to @recipe, notice: 'Review updated' }
        format.json { render :show, location: @recipe  }
        else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete_review
    @review = Review.find(params['id'])
    @recipe = Recipe.find(@review.recipe_id)
     
    respond_to do |format|
      if @review.destroy
        format.html { redirect_to @recipe, notice: 'Review was deleted successfully' }
        format.json { render :show, location: @recipe  }
        else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def parse_url
    url = params['url']
    html_string = open(url, :allow_redirections => :all)
    recipe = Hangry.parse(html_string)
    nutrition = recipe.nutrition

    @recipe = Recipe.new do |r|
      r.name = recipe.name
      r.directions = recipe.instructions
      r.description = recipe.description
      r.origin = recipe.canonical_url
      unless recipe.image_url.nil?
        if recipe.image_url.is_a?(Hash)
          r.remote_picture_url = recipe.image_url.values[0][0].gsub('http://','https://')
        else 
          r.remote_picture_url = recipe.image_url.gsub('http://','https://')
        end
      end
      r.servings = recipe.yield.split('\s')[0] if recipe.yield
      r.prep_time = recipe.total_time
      r.private = true
      unless nutrition.nil?
        r.calories = nutrition[:calories].split('\s')[0] if nutrition[:calories]
        r.fat = nutrition[:total_fat].split('\s')[0] if nutrition[:total_fat]
        r.saturated_fat = nutrition[:saturated_fat].split('\s')[0] if nutrition[:saturated_fat]
        r.carbs = nutrition[:total_carbohydrates].split('\s')[0] if nutrition[:total_carbohydrates]
        r.cholestrol = nutrition[:cholesterol].split('\s')[0] if nutrition[:cholesterol]
        r.sugar = nutrition[:sugar].split('\s')[0] if nutrition[:sugar]
        r.sodium = nutrition[:sodium].split('\s')[0] if nutrition[:sodium]
        r.protein = nutrition[:protein].split('\s')[0] if nutrition[:protein]
      end
    end
    
    i = 0
    while i < recipe.ingredients.length do
      line = recipe.ingredients[i]
      
      if (line !~ /\d.+/)
        line.insert(0, "1 ")
      end
        
      ingredientDetails = Ingreedy.parse(line)
      ingredient = ingredientDetails.ingredient
      quantity = ingredientDetails.amount
      unit = ingredientDetails.unit
      
      if quantity.kind_of?(Array)
        quantity = quantity[0]
      end
      
      quantity = quantity.to_s
      
      if quantity.include?('-')
        quantity = quantity.split("-")[0]
      end
      
      if quantity.empty?
      end
      
      f = quantity.split.map { |r| Rational(r) }.inject(:+).to_f
      
      @ingredient = Ingredient.where(name: ingredient).first
      if @ingredient.nil? 
        @ingredient = Ingredient.create name: ingredient
      end
      
      # Create corresponding instruction
      @instruction = Instruction.new ingredient_id: @ingredient.id, amount: f, unit: unit, prep_note: ""
      # Add associations
      @recipe.instructions << @instruction
      i +=1
    end
    
    @recipe.save
    
    # Make saved recipe entry
    @saved_recipe = SavedRecipe.new user_id: session['user_id'], personal: true, private: true
    @recipe.saved_recipes << @saved_recipe

    if @recipe.save
      redirect_to "/recipes/" + @recipe.id.to_s
    end
  end
  
  def index
    @recipes = Recipe.all
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")
    else
      @recipes = Recipe.all.order("created_at DESC")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :directions, :description, :origin, :picture, :servings, :prep_time, :calories, :cholestrol)
    end
end
