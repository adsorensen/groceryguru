# == Schema Information
#
# Table name: meal_plans
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class MealPlan < ActiveRecord::Base
    has_many :recipes, through: :Plans
    belongs_to :users
end
