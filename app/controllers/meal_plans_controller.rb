class MealPlansController < ApplicationController
    before_action :set_plan, only: [:show, :destroy]
    
    # POST /mealplans
    def create
        @mealplan = MealPlan.new(:name => params['name'], :user_id => session['user_id'])
        @mealplan.save
        
        # Add associated recipe to new plan
        recipe  = Recipe.find(params['recipe'])
        
        if !recipe.nil?
            planAsc = Plan.new(:recipe_id => recipe.id, :meal_plan_id => @mealplan.id)
            planAsc.save
        end
        
        render :nothing => true
    end
    
    def add_recipe
        recipe  = Recipe.find(params['recipe'])
        mealPlan = MealPlan.find(params['id'])
        
        planAsc = Plan.new(:recipe_id => recipe.id, :meal_plan_id => mealPlan.id)
        planAsc.save
        
        render :nothing => true
    end
    
    # GET /mealplans
    def index
        @sponsored = MealPlan.where(user_id: 1)
        
        @userPlans = MealPlan.where(user_id: session['user_id'])
    end
    
    # GET /mealplans/1
    def show
        @recipes = []
        query = "select * from recipes as r, plans as p  where r.id=p.recipe_id and p.meal_plan_id="+@mealplan.id.to_s+";"
        results = ActiveRecord::Base.connection.exec_query(query)
        results.each do |entry|
           recipe = Recipe.find(entry['recipe_id'])
           @recipes.push(recipe)
        end
        
    end
    
    def destroy
        @mealplan.destroy
        respond_to do |format|
            format.html { redirect_to @mealplan, notice: 'Meal plan was successfully deleted.' }
            format.json { head :no_content }
        end
    end
    
    def user_plans
        user = User.find(session['user_id'])
        
        mealPlans = MealPlan.select("id, name").where(user_id: user.id)
    
        # json = '{'
        # mealPlans.each do |plan|
        #     json += '"#{plan.id}": "#{plan.name}"\n'
        # end
        # json += '}'
        
        respond_to do |format|
          format.json { render json: mealPlans.to_json }
        end
    end
    
    private
        def set_plan
            @mealplan = MealPlan.find(params[:id])
        end
    
end
