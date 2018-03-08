# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  price       :float(24)        not null
#  walmart_url :string(255)
#  kroger_url  :string(255)
#  brand       :string(255)      not null
#  ttl         :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
    belongs_to :ingredients
end
