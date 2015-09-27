class User < ActiveRecord::Base
  has_secure_password
  has_many :created_teams, class_name: 'Team', foreign_key: 'created_user_id', inverse_of: :creator
  has_many :created_projects, class_name: 'Project', foreign_key: 'creator_id', inverse_of: :creator
  has_many :created_todos, class_name: 'Todo', foreign_key: 'creator_id', inverse_of: :creator
  has_many :assigned_todos, class_name: 'Todo', foreign_key: 'creator_id', inverse_of: :assignee

  has_many :team_members
  has_many :teams, through: :team_members
end
