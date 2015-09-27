class ProjectMember < ActiveRecord::Base
  enum role: [:admin, :normal, :visitor]
  belongs_to :user
  belongs_to :project
end
