class User < ActiveRecord::Base
  has_secure_password
  has_many :teams, foreign_key: 'created_user_id', inverse_of: :creator
end
