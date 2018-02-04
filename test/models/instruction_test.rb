# == Schema Information
#
# Table name: instructions
#
#  id            :integer          not null, primary key
#  recipe_id     :integer          not null
#  ingredient_id :integer          not null
#  amount        :float(24)        not null
#  unit          :string(255)
#  prep_note     :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class InstructionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
