# == Schema Information
#
# Table name: prep_notes
#
#  id         :integer          not null, primary key
#  note       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PrepNote < ActiveRecord::Base
end
