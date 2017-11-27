class Recipe < ActiveRecord::Base
    has_many :instructions
    has_many :saved_recipes
    has_many :ingredients, :through => :instructions
    has_many :users, :through => :saved_recipes
    accepts_nested_attributes_for :instructions
end
