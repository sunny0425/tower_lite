class Event < ActiveRecord::Base
  belongs_to :activist, class_name: 'User', foreign_key: 'activist_id'
  belongs_to :eventable, polymorphic: true
  has_many :comments

end
