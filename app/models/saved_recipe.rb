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

class SavedRecipe < ActiveRecord::Base
    belongs_to :recipes
    belongs_to :users
end
