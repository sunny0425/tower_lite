class TeamMembersController < ApplicationController
  before_action :require_login
  before_action :set_team
  before_action :set_team_member, only: [:edit, :udpate, :destroy]
  before_action :require_member
  before_action :require_admin, except: [:index]

  def index
    @members = @team.members.includes(:user)
  end

  def new
    @member = @team.members.build(role: TeamMember::roles[:normal])
  end

  def create
    @member = @team.members.build(team_member_params)

    if @member.save
      redirect_to team_team_members_path(@team), notice: 'Team member was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @member.update_attributes(team_member_params)

    if @member.save
      redirect_to team_team_members_path(@team), notice: 'Team member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to team_team_members_path(@team), notice: 'Team member was successfully destroyed.'
  end
  
  private
  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_team_member
    @member = @team.members.find(params[:id])
  end

  def require_member
    if @team.members.where(user_id: current_user.id).exists?
      return true
    else
      bounce! 'Sorry, you do not have permission' unless current_user
    end
  end

  def require_admin
    if @team.members.admin.where(user_id: current_user.id).exists?
      return true
    else
      bounce! 'Sorry, you do not have permission' unless current_user
    end
  end

  def team_member_params
    params.require(:team_member).permit(:email, :role)
  end
  
end
