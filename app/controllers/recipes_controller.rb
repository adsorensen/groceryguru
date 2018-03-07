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
  
  # GET /recipes/url
  def url
    @recipe = Recipe.new
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
      # Add assotiations
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
      params.require(:recipe).permit(:name, :directions, :description, :origin, :picture, :servings, :prep_time)
    end
    
    def process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
        r.base_uri.to_s
      end
    end
end
