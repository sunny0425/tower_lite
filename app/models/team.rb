class Team < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'created_user_id'
  has_many :members, class_name: 'TeamMember'
  has_many :projects
  has_many :events

  after_create :add_memmber_admin

  def add_memmber_admin
    if self.created_user_id.present?
      self.members.create(user_id: self.created_user_id, role: 'admin')
    end
  end
  
end
