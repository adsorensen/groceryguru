class MealPlansController < ApplicationController
    before_action :set_plan, only: [:show, :edit, :update, :destroy]
    
    def create
    end
    
    def add_recipe
    end
    
    def remove_recipe
    end
    
    private
        def set_plan
        end
    
end
