# frozen_string_literal: true

# API for managing groups associated with team
class Api::V1::GroupsController < ApiController
  before_action :set_group, except: [:index, :create, :destroy_all]

  # GET /groups
  def index
    paginate = pagination_params(params)
    user_groups = current_team.groups.all
                              .order(paginate[:order_by])
                              .page(paginate[:page])
                              .per(paginate[:per_page])

    groups = ActiveModelSerializers::SerializableResource.new(user_groups)
    render_success(groups, pagination_dict(user_groups))
  end

  # GET /groups/1
  def show
    render_success(GroupSerializer.new(@group).as_json)
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      render_success(GroupSerializer.new(@group).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @group.errors.full_messages.join(","), @group.errors)
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update_attributes(group_params)
      render_success(GroupSerializer.new(@group).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity], @group.errors.full_messages.join(","), @group.errors)
    end
  end

  # DELETE /groups/1
  def destroy_all
    team = current_team

    params[:groups].each do |group|
      group = team.groups.find(group[:id])
      #TODO: should we check if an event uses this?
      group.destroy
    end
    render_success(success: true)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :team_id)
  end
end
