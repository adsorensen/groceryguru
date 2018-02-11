# == Schema Information
#
# Table name: meal_plans
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

require 'test_helper'

class MealPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
