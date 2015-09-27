class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo
  has_many :events, as: :eventable

  after_create :add_newly_event
  after_update :add_update_event

  def add_newly_event
    self.events.create(
      activist_id: self.creator_id,
      content: '回复了任务'
    )
  end

  def add_update_event
    if self.is_deleted_changed? && self.is_deleted
      self.events.create(
      activist_id: self.creator_id,
      content: '删除了回复'
    )
    end
  end

end
