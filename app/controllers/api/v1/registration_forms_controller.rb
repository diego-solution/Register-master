# frozen_string_literal: true

# Handles registration forms for events. IT IS WIP
class Api::V1::RegistrationFormsController < ApiController
  before_action :set_registration_form, only: [:show, :update, :destroy]
  before_action :get_pagination, only: [:index]
  before_action :get_language, only: [:show, :create, :update]

  # GET /registration_forms
  def index
    db_forms = current_team.registration_forms
                           .order(@paginate[:order_by])
                           .page(@paginate[:page])
                           .per(@paginate[:per_page])

    reg_forms = ActiveModelSerializers::SerializableResource.new(db_forms, include: ['registration_questions', 'registration_options'])
    render_success(reg_forms, pagination_dict(db_forms))
  end

  # GET /registration_forms/1
  def show
    p = serialized_registration_form(params[:edit])
     
    I18n.with_locale(@language.key) do
      result = serialized_registration_form(params[:edit])
       
      render_success(result)
    end
  end

  # GET /registration_forms/new
  def new
    @registration_form = RegistrationForm.new(name: "Standard")

    # create questions for forms
    f = { "en": "First Name" }
    q = RegistrationQuestion.new(kind: "single", required: true, 
                                 width: "50%",
                                 placeholder: "John",
                                 question_translations: f)

    @registration_form.registration_questions << q

    f = { "en": "Last Name" }
    q = RegistrationQuestion.new(kind: "single", required: true, 
                                 width: "50%",
                                 placeholder: "Smith",
                                 question_translations: f)
    @registration_form.registration_questions << q

    f = { "en": "Email" }
    q = RegistrationQuestion.new(kind: "email", required: true,
                                 width: "100%",
                                 placeholder: "john@eventfuel.io",
                                 question_translations: f)
    @registration_form.registration_questions << q

    render_success(serialized_registration_form(true))
  end

  # POST /registration_forms
  def create
    I18n.with_locale(@language.key) do
      @registration_form = RegistrationForm.new(registration_form_params)
      @registration_form.team = current_team
      if @registration_form.save
        render_success(serialized_registration_form(true))
      else
        render_error(RESPONSE_CODE[:unprocessable_entity],
                     @registration_form.errors.full_messages.join(","),
                     @registration_form.errors)
      end
    end
  end

  # PATCH/PUT /registration_forms/1
  def update
    I18n.with_locale(@language.key) do
      if @registration_form.update(registration_form_params)
        render_success(serialized_registration_form(true))
      else
        render_error(RESPONSE_CODE[:unprocessable_entity],
                     @registration_form.errors.full_messages.join(","),
                     @registration_form.errors)
      end
    end
  end

  # DELETE /registration_forms/1
  def destroy
    @registration_form.destroy
    render_success(success: true)
  end

  def destroy_all
    params[:registration_forms].each do |registration_form|
      registration_form = current_team.registration_forms.find(registration_form[:id])
      #TODO: should we check if an event uses this?
      #return  registration_form.destroy
      unless registration_form.destroy
        render_error(RESPONSE_CODE[:unprocessable_entity],
                     registration_form.errors.full_messages.join(","),
                     registration_form.errors)
        return
      end
    end
    render_success(success: true)
  end

  private

  def serialized_registration_form(edit_mode = false)
    RegistrationFormSerializer.new(@registration_form, scope: { 'edit': (edit_mode == "true") }).as_json
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_registration_form
    @registration_form = current_team.registration_forms.find(params[:id])
  end

  def get_language
    language_code = params[:language_id] || "en"
    @language = Language.find_by key: language_code
  end
  
  def get_pagination
    @paginate = pagination_params(params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registration_form_params
    params.require(:registration_form).permit(:team_id, :name, :archived,
                                              registration_questions_attributes: [:id, :_destroy, :help_text,
                                                                                  :kind, :placeholder,
                                                                                  :position, :question,
                                                                                  :required,
                                                                                  registration_options_attributes: [:id,
                                                                                                                :_destroy,
                                                                                                                :option,
                                                                                                                :position,
                                                                                                                :value]])
  end
end
