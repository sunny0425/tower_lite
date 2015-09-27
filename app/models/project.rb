class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :creator, class_name: 'User'
  has_many :todos
  has_many :events
end
