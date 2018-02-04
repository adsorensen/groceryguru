class MealPlan < ActiveRecord::Base
    has_many :recipes, through: :Plans
    belongs_to :users
end
