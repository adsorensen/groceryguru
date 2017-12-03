# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#  text       :string(255)      not null
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ActiveRecord::Base
     belongs_to :recipes
     belongs_to :users
end
