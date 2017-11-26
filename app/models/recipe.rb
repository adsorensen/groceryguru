class Recipe < ActiveRecord::Base
    has_many :instructions
    has_many :ingredients, :through => :instructions
    accepts_nested_attributes_for :instructions
end
