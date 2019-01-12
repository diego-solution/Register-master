# frozen_string_literal: true

# serializer for page layout
class PageLayoutSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :is_original, :header, :sidebar, :body, :footer, :name, :disable_sidebar, :preview_image
end
