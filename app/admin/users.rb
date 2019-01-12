ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :password, :super_admin
  actions :all, except: [:new]

  filter :email
  filter :created_at

  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :super_admin
    column :updated_at
    actions
  end

  action_item :reset_password, only: :show do
    link_to "Reset Password", reset_pass_omega_user_path(resource.id)
  end

  member_action :reset_pass, method: :get do
    resource.send_reset_password_instructions
    redirect_to omega_users_path, notice: "Sent reset password instructions to email"
  end

  # action_item :login_as, only: :show do
  #   link_to 'Login as', login_as_omega_user_path(resource.id)
  # end

  # member_action :login_as, :method => :get do
  #   user = User.find(params[:id])
  #   sign_in(user, bypass: true)
  #   redirect_to dashboard_path
  # end

  form do |f|
    f.inputs "Personal" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :super_admin
      #f.input :password
    end

    # f.inputs "Associated Organisation" do
    #   f.input :team_memberships
    # end
 
    f.actions
  end
  

  # controller do
  #   def scoped_collection
  #     super.includes :location
  #   end
  # end
end
