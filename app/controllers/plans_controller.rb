class PlansController < ApplicationController
    before_action :set_plan, only: [:show, :edit, :update, :destroy]

    def destroy
        mealPlan = @plan.find_by(meal_plan_id: @plan.meal_plan_id)
        @plan.destroy
        
        respond_to do |format|
            format.html { redirect_to mealPlan, notice: 'Recipe was successfully deleted.' }
            format.json { head :no_content }
        end
    end
    
    private
        def set_plan
            @plan = Plan.find(params[:id])
        end
    
end