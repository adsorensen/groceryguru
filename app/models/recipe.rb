# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  directions  :text(65535)      not null
#  description :string(255)
#  origin      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  picture     :string(255)
#

class Recipe < ActiveRecord::Base
    has_many :instructions
    has_many :saved_recipes
    has_many :reviews
    has_many :ingredients, :through => :instructions
    has_many :users, :through => :saved_recipes
    accepts_nested_attributes_for :instructions
    

    def self.search(search)
        where("name LIKE ?", "%#{search}%") 
    end
    
end
