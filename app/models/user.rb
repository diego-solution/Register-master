# frozen_string_literal: true

# a user
# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  confirmation_token      :string
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  unconfirmed_email       :string
#  failed_attempts         :integer          default(0), not null
#  unlock_token            :string
#  locked_at               :datetime
#  password_changed_at     :datetime
#  last_activity_at        :datetime
#  expired_at              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  super_admin             :boolean          default(FALSE)
#  encrypted_first_name    :string
#  encrypted_first_name_iv :string
#  encrypted_last_name     :string
#  encrypted_last_name_iv  :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_expired_at            (expired_at)
#  index_users_on_last_activity_at      (last_activity_at)
#  index_users_on_password_changed_at   (password_changed_at)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable,
         :password_expirable, :password_archivable

  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships

  attr_encrypted :first_name, key: Base64.decode64(ENV["MASTER_KEY"])
  attr_encrypted :last_name, key: Base64.decode64(ENV["MASTER_KEY"])

  # class method to create a random pass. used when creating a user
  def self.generate_random_password
    Devise.friendly_token.first(12)
  end

  # shortcut for name
  def name
    "#{first_name} #{last_name}"
  end

  # return team id and admin, used when changing team context and checking if usr has permissions
  def can_switch_team(team_id_to_access)
    if super_admin
      team_id = Team.find(team_id_to_access).id
      admin   = true
    else
      membership  = team_memberships.find_by!(team_id: team_id_to_access)
      team_id     = membership.team_id
      admin       = membership.admin
    end
    { team_id: team_id, admin: admin }
  end

  # used to generate a token for the user. could be extended later to save this into db
  def login_with_token!(team_id = nil, is_admin = nil)
    # ensure we have data
    if team_id.nil?
      team_id  = team_memberships.first.try(:team_id)
      is_admin = super_admin ? true : team_memberships.first.try(:admin)
    end

    JsonWebToken.encode(
      sub: id,
      name: name,
      email: email,
      team: team_id,
      admin: is_admin,
      super_admin: super_admin
    )
  end

  def generate_welcome_email(team_name = "")
    team_name = team_memberships.first.team.name if team_name.blank?
    pass      = User.generate_random_password
    return false unless update_attributes(password: pass, password_confirmation: pass)
    send_welcome_email(pass, team_name)
  end

  private

  # for new users
  def send_welcome_email(new_password, team_name)
    return false if email.blank?
    return true if InformationsMailer.welcome_user(name, email, new_password, team_name).deliver
  end
end
