class Instruction < ActiveRecord::Base
    enum unit: [ :cups, :tablespoons, :teaspoons, :ounces, :drops, :pinch, :liters, :milliliters ]
end
