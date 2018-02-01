class MealPlan < ActiveRecord::Base
    has_many :recipes, through: :Plans
end
