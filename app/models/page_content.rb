# frozen_string_literal: true
# == Schema Information
#
# Table name: page_contents
#
#  id                   :integer          not null, primary key
#  team_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  disable_sidebar      :boolean          default(FALSE)
#  header_translations  :json
#  sidebar_translations :json
#  body_translations    :json
#  footer_translations  :json
#  preview_image        :text
#  name                 :string
#  page_layout_id       :integer
#  event_id             :integer
#
# Indexes
#
#  index_page_contents_on_event_id        (event_id)
#  index_page_contents_on_page_layout_id  (page_layout_id)
#  index_page_contents_on_team_id         (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#

class PageContent < ApplicationRecord
  belongs_to :team
  belongs_to :page_layout
  belongs_to :event

  translates :header
  translates :sidebar
  translates :body
  translates :footer

  has_paper_trail

  def self.init_from_page_layout(page_layout_ident)
    layout = PageLayout.find page_layout_ident
    return if layout.nil?

    PageContent.new(team: layout.team,
                    name: layout.name,
                    page_layout: layout,
                    disable_sidebar: layout.disable_sidebar,
                    header_translations: layout.header_translations,
                    sidebar_translations: layout.sidebar_translations,
                    body_translations: layout.body_translations,
                    footer_translations: layout.footer_translations)
  end

  def header_html
    ContentTagsService.new(event: event).replace_tags(header)
  end

  def body_html
    ContentTagsService.new(event: event).replace_tags(body)
  end

  def footer_html
    ContentTagsService.new(event: event).replace_tags(footer)
  end

  def sidebar_html
    return "" if disable_sidebar
    ContentTagsService.new(event: event).replace_tags(sidebar)
  end
end
