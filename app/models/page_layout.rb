# frozen_string_literal: true
# == Schema Information
#
# Table name: page_layouts
#
#  id                   :integer          not null, primary key
#  name                 :string
#  is_original          :boolean          default(TRUE)
#  disable_sidebar      :boolean          default(FALSE)
#  preview_image        :text
#  header_translations  :json
#  sidebar_translations :json
#  body_translations    :json
#  footer_translations  :json
#  team_id              :integer
#  page_layout_id       :integer
#  deleted_at           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_page_layouts_on_page_layout_id  (page_layout_id)
#  index_page_layouts_on_team_id         (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_layout_id => page_layouts.id)
#  fk_rails_...  (team_id => teams.id)
#

class PageLayout < ApplicationRecord
  belongs_to :team, optional: true
  #belongs_to :page_layout, optional: true
  has_many :events, dependent: :nullify

  translates :header
  translates :sidebar
  translates :body
  translates :footer

  scope :templates, -> { where(is_original: true) }
  scope :saved, -> { where(is_original: false) }
end
