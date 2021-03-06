# == Schema Information
#
# Table name: meal_plans
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  private    :boolean          not null
#

class MealPlan < ActiveRecord::Base
    has_many :plans
    has_many :recipes, :through => :plans
    belongs_to :users
end
