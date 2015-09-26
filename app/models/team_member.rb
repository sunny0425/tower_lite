class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  enum role: [:admin, :normal, :visitor]
  validates_presence_of :user_id, :team_id, :role

  attr_accessor :email

  def email=(email)
    user = User.find_by email: email
    if user.present?
      self.user_id = user.id
    else
      errors.add(:base, 'user not exist')
      return false
    end
  end

  def email
    if self.user
      return self.user.email
    else
      nil
    end
  end

  def role=(value)
    if value.kind_of?(String) and value.to_i.to_s == value
      super value.to_i
    else
      super value
    end
  end
end
