class Team < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'created_user_id'
end
