# == Schema Information
#
# Table name: recipes
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :string(255)
#  ingredients  :text(65535)
#  instructions :string(255)
#  note         :string(255)
#  tags         :string(255)
#  origin       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Recipe < ActiveRecord::Base
end
