# == Schema Information
#
# Table name: saved_recipes
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#  personal   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean
#

require 'test_helper'

class SavedRecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
