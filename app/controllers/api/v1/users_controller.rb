# frozen_string_literal: true

# API for managing users associated with team
class Api::V1::UsersController < ApiController
  before_action :set_user, except: [:index, :create, :destroy_all]

  # GET /users
  def index
    team_users = search_teams
    users = ActiveModelSerializers::SerializableResource.new(team_users)
    render_success(users, pagination_dict(team_users))
  end

  # GET /users/1
  def show
    render_success(UserSerializer.new(@user).as_json)
  end

  # POST /users
  def create
    if create_user_for_team && @user.generate_welcome_email()
      render_success(UserSerializer.new(@user).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @user.errors.full_messages.join(","),
                   @user.errors)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update_attributes(user_params)
      render_success(UserSerializer.new(@user).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @user.errors.full_messages.join(","),
                   @user.errors)
    end
  end

  # DELETE /users/1
  def destroy_all
    team_id = current_team

    params[:users].each do |user|
      user = TeamMembership.where(user_id: user[:id], team_id: team_id).first
      #TODO: should we check if an event uses this?
      user&.destroy
    end
    render_success(success: true)
  end

  def resend_welcome_email
    if @user.generate_welcome_email(current_team.name)
      render_success(UserSerializer.new(@user).as_json)
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   @user.errors.full_messages.join(","),
                   @user.errors)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def create_user_for_team
    @user = User.create(user_params.merge(password: User.generate_random_password))
    @user.team_memberships << TeamMembership.new(team_membership_params)
    @user.valid?
  end

  def search_teams
    paginate = pagination_params(params)
    User.all.joins(:team_memberships)
        .where(team_memberships: { team_id: current_team })
        .order(paginate[:order_by])
        .page(paginate[:page])
        .per(paginate[:per_page])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def team_membership_params
    params.require(:team_membership).permit(:id, :admin, :team_id, :user_id)
  end
end
