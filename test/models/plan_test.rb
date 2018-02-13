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

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
