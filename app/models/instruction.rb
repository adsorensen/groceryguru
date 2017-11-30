# == Schema Information
#
# Table name: instructions
#
#  id            :integer          not null, primary key
#  recipe_id     :integer          not null
#  ingredient_id :integer          not null
#  amount        :integer          not null
#  unit          :integer
#  prep_note     :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Instruction < ActiveRecord::Base
    belongs_to :recipes
    belongs_to :ingredients
    enum unit: [ :cups, :tablespoons, :teaspoons, :ounces, :drops, :pinchs, :liters, :milliliters ]
end
