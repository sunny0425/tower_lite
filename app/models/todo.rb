class Todo < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', inverse_of: 'created_todos'
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id',
    inverse_of: 'updated_todos'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', inverse_of: 'assigned_todos'

  has_many :events, as: :eventable

  after_create :add_newly_event
  after_update :add_update_event

  def add_newly_event
    self.events.create(
      activist_id: self.creator_id,
      content: '创建了任务'
    )
  end

  def add_update_event
    _content = nil
    
    if self.end_date_changed?
      _content = "任务完成时间修改为：#{self.end_date}"
    elsif self.assignee_id.changed? && self.assignee.present?
      _content = "给 #{self.assignee.name} 指派了任务"
    elsif self.is_done.changed? && self.is_done
      _content = "完成了任务"
    end

    if _content.present?
      self.events.create(
        activist_id: self.updated_user_id,
        content: _content
      )
    end
  end
end
