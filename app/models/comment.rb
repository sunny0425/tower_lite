class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo
  has_many :events, as: :eventable

  after_create :add_newly_event
  after_update :add_update_event

  def project
    @project ||= self.todo.project
  end

  def team
    @team ||= project.team
  end

  def add_newly_event
    self.events.create(
      activist_id: self.creator_id,
      content: '回复了任务',
      project_id: project.id,
      team_id: team.id
    )
  end

  def add_update_event
    if self.is_deleted_changed? && self.is_deleted
      self.events.create(
      activist_id: self.creator_id,
      content: '删除了回复',
      project_id: project.id,
      team_id: team.id
    )
    end
  end

end
