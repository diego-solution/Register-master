ActiveAdmin.register Translation do

  permit_params :namespace, :key, :text, :team_id, :language_id

  scope :defaults

  filter :namespace
  filter :key
  filter :text
  filter :team
  filter :language

  index do
    selectable_column
    column :language
    column :namespace
    column :key
    column :text
    column :team
    actions
  end
 
  form do |f|
    f.inputs do
      f.input :namespace
      f.input :key
      f.input :text
      f.input :language
      f.input :team
    end
    f.actions
  end
  

  controller do
    def scoped_collection
      super.includes :language
    end
  end
end
