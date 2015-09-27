class TodosController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:index]
  before_action :require_member

  def index
    @todos = @project.todos
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def require_member
  end

end
