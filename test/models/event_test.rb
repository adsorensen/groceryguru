# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  start_time :string(255)
#  end_time   :string(255)
#  allday     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :string(255)
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
