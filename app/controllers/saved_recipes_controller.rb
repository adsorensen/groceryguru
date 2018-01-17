class SavedRecipesController < ApplicationController
  before_action :set_saved_recipe, only: [:show, :edit, :update, :destroy]

  # GET /saved_recipes
  # GET /saved_recipes.json
  def index
    @saved_recipes = SavedRecipe.all
  end

  # GET /saved_recipes/1
  # GET /saved_recipes/1.json
  def show
  end

  # GET /saved_recipes/new
  def new
    @saved_recipe = SavedRecipe.new
  end

  # GET /saved_recipes/1/edit
  def edit
  end

  # POST /saved_recipes
  # POST /saved_recipes.json
  def create
    query = SavedRecipe.where(user_id: params[:user_id], recipe_id: params[:recipe_id])
    if query.first
      redirect_to '/users/' + session['user_id'].to_s
      return
    else
      @saved_recipe = SavedRecipe.new(:user_id => params[:user_id], :recipe_id => params[:recipe_id], :personal => params[:personal])
    end

    respond_to do |format|
      if @saved_recipe.save
        format.html { redirect_to '/users/' + session['user_id'].to_s, notice: 'Saved recipe was successfully created.' }
        format.json { render :show, status: :created, location: @saved_recipe }
      else
        format.html { render :new }
        format.json { render json: @saved_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saved_recipes/1
  # PATCH/PUT /saved_recipes/1.json
  def update
    respond_to do |format|
      if @saved_recipe.update(saved_recipe_params)
        format.html { redirect_to @saved_recipe, notice: 'Saved recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @saved_recipe }
      else
        format.html { render :edit }
        format.json { render json: @saved_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_recipes/1
  # DELETE /saved_recipes/1.json
  def destroy
    @saved_recipe.destroy
    respond_to do |format|
      format.html { redirect_to '/users/' + session[:user_id].to_s, notice: 'Saved recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_recipe
      @saved_recipe = SavedRecipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saved_recipe_params
      params.require(:saved_recipe).permit(:personal)
    end
end
