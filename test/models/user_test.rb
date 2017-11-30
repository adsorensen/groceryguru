# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean
#  gluten_free     :boolean
#  lactose_intol   :boolean
#  organic         :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  bio             :string(255)
#  picture         :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
