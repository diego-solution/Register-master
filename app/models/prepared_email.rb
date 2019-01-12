# frozen_string_literal: true

# == Schema Information
#
# Table name: prepared_emails
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  from_address :string
#  to_addresses :text
#  subject      :string
#  content      :text
#  send_date    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_prepared_emails_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#

class PreparedEmail < ApplicationRecord
  belongs_to :team
end
