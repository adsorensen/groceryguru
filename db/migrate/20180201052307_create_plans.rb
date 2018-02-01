class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.refrences :recipe
      t.refrences :meal_plan

      t.timestamps null: false
    end
  end
end
