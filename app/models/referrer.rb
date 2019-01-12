# frozen_string_literal: true

# == Schema Information
#
# Table name: referrers
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  token      :string
#  link       :string
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# the person who registered to refer some registrants (aka affiliate)
class Referrer < ApplicationRecord
  has_secure_token

  belongs_to :event, optional: true

  has_paper_trail

  validates :name, :email, presence: true
  after_create :send_referrer_link_to_email, if: proc { |ref| ref.event }

  def link
    "#{ENV['DOMAIN']}/#/#{token}/#{event.internal_name}"
  end

  private

  def send_referrer_link_to_email
    InformationsMailer.referrer_link(self).deliver if email
  end
end
