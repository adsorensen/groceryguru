class MealPlanPrivate < ActiveRecord::Migration
  def change
    add_column :meal_plans, :private, :boolean, null: false
  end
end
