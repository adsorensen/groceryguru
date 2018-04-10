# == Schema Information
#
# Table name: checkout_lists
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  ingredient_id :integer          not null
#  quantity      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ingr_name     :string(255)
#  unit          :boolean
#

class CheckoutList < ActiveRecord::Base
    belongs_to :users
    belongs_to :ingredients
    
end
