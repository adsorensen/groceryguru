class SavedRecipe < ActiveRecord::Base
    belongs_to :recipes
    belongs_to :users
end
