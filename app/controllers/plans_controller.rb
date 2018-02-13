class PlansController < ApplicationController
    before_action :set_plan, only: [:destroy]

    def destroy
        @mealplan = MealPlan.find(@plan.meal_plan_id)
        @plan.destroy
        
        respond_to do |format|
            format.html { redirect_to '/mealplans/'+@mealplan.id.to_s, notice: 'Recipe was successfully removed.' }
            format.json { head :no_content }
        end
    end
    
    private
        def set_plan
            @plan = Plan.find(params[:id])
        end
    
end