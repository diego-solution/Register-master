# frozen_string_literal: true

# API for managing translations associated with team
class Api::V1::TranslationsController < ApiController
  before_action :set_team, only: [:index, :create]
  before_action :set_language, only: [:index, :create]

  # GET /translations
  def index
    translations = Translation.mixed_content_for_team(@language.id, @team.id)
                              .group_by(&:namespace)
    # dont load empty screen
    if translations.empty?
      logger.info "translations are empty"
      translations = Translation.defaults.by_language(Language.first.id)
                                .group_by(&:namespace)
    end
    render_success(translations.as_json)
  end

  # original english texts
  def original
    translations = Translation.defaults.by_language(Language.first.id)
    render_success(translations.as_json)
  end

  def create
    errors = update_translations
    if errors.empty?
      render_success(message: "yeaa!")
    else
      render_error(RESPONSE_CODE[:unprocessable_entity],
                   errors.to_s,
                   errors)
    end
  end

  private

  def update_translations
    errors = []
    Translation.transaction do
      translation_params.each do |trans|
        translation = Translation.find_or_initialize_by(key: trans["key"],
                                                        language_id: @language.id,
                                                        team_id: @team.id,
                                                        namespace: trans["namespace"])
        translation.text = trans["text"]
        errors << translation.errors.full_messages.join(",") if !translation.save
      end
    end
    errors
  end

  # # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_language
    @language = Language.find(params[:language_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def translation_params
    params.require(:translations) #.permit(:key, :text)
  end
end
