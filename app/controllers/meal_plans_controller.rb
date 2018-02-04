class MealPlansController < ApplicationController
    before_action :set_plan, only: [:show, :edit, :update, :destroy]
    
    # POST /meal_plans
    def create
        @plan= MealPlan.new(:name => params['name'])
    end
    
    def add_recipe
    end
    
    def remove_recipe
    end
    
    # GET /mealplans
    def index
        @plans = MealPlan.all
    end
    
    # GET /mealplans/1
    def show
        @recipes = Recipe.all
        @cart = Cart.all
    end
    
    private
        def set_plan
            @plan = MealPlan.find(params[:id])
        end
    
end
