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

  # POST /recipes
  # POST /recipes.json
  # original
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    
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
        @ingredient = Ingredient.new name: ingredient
        @ingredient.save
      end
      
      # Create corresponding instruction
      Instruction.create amount: quantity, unit: unit, recipe_id: @recipe.id, ingredient_id: @ingredient.id, prep_note: prep
      
      count += 1
    end

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
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def review
    uid = session["user_id"]
    @review = Review.create recipe_id: params[:id], user_id: uid, text: params['review'], rating: params["rating"]
    
    
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
  
  def url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :directions, :description, :origin, :picture)
    end
end
