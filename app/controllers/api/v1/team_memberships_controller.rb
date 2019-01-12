# frozen_string_literal: true

# API for obtaining team memberships
class Api::V1::TeamMembershipsController < ApiController
  before_action :set_team_membership, only: [:show, :update]

  # GET /team_memberships/1
  def show
    render_success(TeamMembershipSerializer.new(@team_membership).as_json)
  end

  # PATCH/PUT /users/1
  def update
    if @team_membership.update_attributes(team_membership_params)
      render_success(TeamMembershipSerializer.new(@team_membership).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @team_membership.errors.full_messages.join(","),
                   @team_membership.errors)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team_membership
    @team_membership = TeamMembership.find_by(team_id: params[:id], user_id: params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_membership_params
    params.require(:team_membership).permit(:user_id, :team_id, :admin)
  end
end
