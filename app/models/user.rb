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

class User < ActiveRecord::Base
    has_many :saved_recipes
    has_many :recipes, :through => :saved_recipes
    has_many :reviews
    has_many :meal_plans
    has_many :events
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }, if: proc { |user| user.new_record? }
    validate  :picture_size

    before_save { email.downcase! }

    has_secure_password
    
    mount_uploader :picture, PictureUploader
    
    def full_name
    "#{first_name} #{last_name}".strip
    end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  private# Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
