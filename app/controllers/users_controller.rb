class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    recipe_ids = SavedRecipe.where(user_id: @user.id).order(created_at: :desc)
    saved_recipes = Array.new
    personal_recipes = Array.new
    for recipe_id in recipe_ids do
      recipe = Recipe.where(id: recipe_id.recipe_id)
      if(recipe_id.personal) 
        personal_recipes << recipe
      else
        saved_recipes << recipe
      end
    end
    @saved_recipes = saved_recipes
    @personal_recipes = personal_recipes
    @meal_plans =  MealPlan.where(user_id: @user.id)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/users/" + session["user_id"].to_s, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def home
    if logged_in?
      redirect_to '/users/' + session[:user_id].to_s
    else
      redirect_to new_age_index_path
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :password, :admin, :username, :first_name, :last_name, :email, :gluten_free, :lactose_intol, :organic, :bio, :picture)
    end
end
