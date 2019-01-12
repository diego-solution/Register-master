# frozen_string_literal: true

# serializer for page content
class PageContentSerializer < ActiveModel::Serializer
  attributes :id, 
             :name, :disable_sidebar,
             :header, :sidebar, :body, :footer,
             :preview_image, :page_layout_id,
             :header_html, :body_html, :footer_html, :sidebar_html
end
