# == Schema Information
#
# Table name: recipes
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  directions    :text(65535)      not null
#  description   :string(255)
#  origin        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  picture       :string(255)
#  servings      :integer
#  prep_time     :integer
#  private       :boolean          not null
#  calories      :decimal(10, )
#  fat           :decimal(10, )
#  saturated_fat :decimal(10, )
#  carbs         :decimal(10, )
#  cholestrol    :decimal(10, )
#  sugar         :decimal(10, )
#  sodium        :decimal(10, )
#  protein       :decimal(10, )
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
