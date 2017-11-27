class Instruction < ActiveRecord::Base
    belongs_to :recipes
    belongs_to :ingredients
    enum unit: [ :cups, :tablespoons, :teaspoons, :ounces, :drops, :pinchs, :liters, :milliliters ]
end