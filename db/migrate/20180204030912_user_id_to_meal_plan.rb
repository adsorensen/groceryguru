class UserIdToMealPlan < ActiveRecord::Migration
  def change
    add_column :meal_plans, :user_id, :int
    add_foreign_key :meal_plans, :users
  end
end
