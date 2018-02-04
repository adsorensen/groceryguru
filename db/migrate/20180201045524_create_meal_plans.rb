class CreateMealPlans < ActiveRecord::Migration
  def change
    create_table :meal_plans do |t|
      t.string  :name, null: false
      
      t.timestamps null: false
    end
  end
end
