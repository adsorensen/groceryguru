class MealPlanUserNull < ActiveRecord::Migration
  def change
    change_column_null :meal_plans, :user_id, false
  end
end
