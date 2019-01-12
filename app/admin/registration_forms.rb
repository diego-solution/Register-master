ActiveAdmin.register RegistrationForm do
  permit_params :name, :team_id, :archived, 
    registration_questions_attributes: [:_destroy, :registration_form_id, :position, :question_translations, :questions, :id, :kind, :required, :width, :help_text, :placeholder, :help_text_translations, :placeholder_translations, 
    registration_options_attributes: [ :position, :id, :options, :option_translations, :value, :_destroy]]

  
  scope :archived

  filter :name
  filter :team

  index do
    selectable_column
    column :name
    column :team
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :team
      f.input :archived    
    end

    f.has_many :registration_questions, allow_destroy: true do |q|
      q.input :required, as: :boolean
      q.input :position, as: :number
      q.input :kind, as: :select, collection: %w[single email single_other multiple multiple_other text tickbox section]

      q.input :question_translations, as: :string
      q.input :help_text_translations, as: :string
      q.input :placeholder_translations, as: :string
      q.has_many :registration_options, allow_destroy: true do |o|
        o.input :position
        o.input :value, as: :string
        o.input :option_translations, as: :string
        o.input :_destroy
      end
       
    end
 
    f.actions
  end

  controller do
    def scoped_collection
      super.includes :registration_questions, :team
    end
  end
end
