class AddFieldsToPageContents < ActiveRecord::Migration[5.1]
  def change
    add_column :page_contents, :disable_sidebar, :boolean, default: false
    add_column :page_contents, :header_translations, :json
    add_column :page_contents, :sidebar_translations, :json
    add_column :page_contents, :body_translations, :json
    add_column :page_contents, :footer_translations, :json
    add_column :page_contents, :preview_image, :text
    add_column :page_contents, :name, :string
    add_reference :page_contents, :page_layout, index: true
    add_reference :page_contents, :event, index: true

    remove_column :page_contents, :content_translations, :json
    remove_column :page_contents, :kind, :string
  end
end
