class Plan < ActiveRecord::Base
    belongs_to :meal_plans
    belongs_to :recipes
end
