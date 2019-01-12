ActiveAdmin.register Language do
  menu parent: "Translations"

  permit_params :english_name, :key, :native_name
  
  filter :english_name
  filter :native_name
  filter :key

  index do
    selectable_column
    column :english_name
    column :native_name
    column :key
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :english_name
      f.input :native_name
      f.input :key    
    end
    f.actions
  end
 
  action_item :fix_old_en, only: :index do
    link_to 'Fix old en_EN locales', fix_old_en_omega_languages_path(), :data => {:confirm => "Are you sure? There's no coming back, buddy."}
  end 

  collection_action :fix_old_en, method: :get do 
    Language.fix_invalid_locales
    redirect_to omega_languages_path, notice: "User is back in action."
  end
end
