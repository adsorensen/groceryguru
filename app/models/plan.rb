# == Schema Information
#
# Table name: plans
#
#  id           :integer          not null, primary key
#  recipe_id    :integer          not null
#  meal_plan_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Plan < ActiveRecord::Base
    belongs_to :meal_plans
    belongs_to :recipes
end
