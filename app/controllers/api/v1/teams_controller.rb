# frozen_string_literal: true

# API for managing teams, only access is for team leaders or admins
class Api::V1::TeamsController < ApiController
  before_action :set_team, only: [:show, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    paginate = pagination_params(params)
    if current_user.super_admin
      # logger.debug "is admin"
      data = Team.all.order(paginate[:order_by])
                 .page(paginate[:page])
                 .per(paginate[:per_page])
    else
      # logger.debug "is not admin"
      team_ids = current_user.teams.map(&:id)
      data = Team.where(id: team_ids).order(paginate[:order_by])
                 .page(paginate[:page])
                 .per(paginate[:per_page])
    end

    list = ActiveModelSerializers::SerializableResource.new(data)
    render_success(list, pagination_dict(data))
  end

  # GET /groups/1
  def show
    render_success(TeamSerializer.new(@team).as_json)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    if @team.save
      render_success(TeamSerializer.new(@team).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @team.errors.full_messages.join(","),
                   @team.errors)
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params)
      render_success(TeamSerializer.new(@team).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @team.errors.full_messages.join(","),
                   @team.errors)
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_all
    params[:teams].each do |team|
      team = Team.find(team[:id])
      if current_user.super_admin
        #TODO: should we check if an event uses this?
        team.destroy
      end
    end
    render_success(success: true)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name)
  end
end
