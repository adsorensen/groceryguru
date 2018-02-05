class PlanForKeys < ActiveRecord::Migration
  def change
    drop_table :plans
    create_table :plans do |t|
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
      t.belongs_to :meal_plan, index: true, foreign_key: true, null: false
      
      t.timestamps null: false
    end
  end
end
