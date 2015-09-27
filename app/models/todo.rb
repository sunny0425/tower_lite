class Todo < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', inverse_of: 'created_todos'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', inverse_of: 'assigned_todos'

end
