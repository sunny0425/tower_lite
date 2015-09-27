class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :creator, class_name: 'User'
  has_many :todos
  has_many :events
  has_many :project_members
  has_many :members, through: :project_members
end
