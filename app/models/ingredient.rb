# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ingredient < ActiveRecord::Base
    has_many :instructions
    has_many :recipes, :through => :instructions
    
    def self.search(search)
        where("name LIKE ?", "%#{search}%") 
    end
end
