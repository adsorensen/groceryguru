# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  unit       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ActiveRecord::Base
end
