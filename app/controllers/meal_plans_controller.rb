class MealPlansController < ApplicationController
    before_action :set_plan, only: [:show, :edit, :update, :destroy]
    
    # POST /mealplans
    def create
        @plan= MealPlan.new(:name => params['name'], :user_id => session['user_id'])
        
        @plan.save
        
        render :nothing => true
    end
    
    def add_recipe
        recipe  = Recipe.find(params['recipe'])
        mealPlan = MealPlan.where(:name => params['name'])
        
        mealPlan << recipe
        mealPlan.save
        
        render :nothing => true
    end
    
    def remove_recipe
    end
    
    # GET /mealplans
    def index
        @plans = MealPlan.all
    end
    
    # GET /mealplans/1
    def show
        @recipes = @plan.recipes
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
            @plan = MealPlan.find(params[:id])
        end
    
end
