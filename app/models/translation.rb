# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :integer          not null, primary key
#  namespace   :string
#  key         :string
#  text        :string
#  team_id     :integer
#  language_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_translations_on_language_id  (language_id)
#  index_translations_on_team_id      (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (language_id => languages.id)
#  fk_rails_...  (team_id => teams.id)
#

# Represents a translatable string that is used in the event pages
class Translation < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :language

  scope :defaults, -> { where(team_id: nil) }
  scope :by_language, ->(lang_id) { where(language_id:  lang_id) }

  # returns default translations mixed with a set of db translations
  def self.mixed_content_for_team(language_id, team_id)
    team_translations = team_translations_by_lang(language_id, team_id)
    app_defaults      = defaults.where(language_id: language_id).order("key asc")

    # no translation for this team, return default values
    return app_defaults if team_translations.empty?

    # no defaults for that language... so return team ones
    return team_translations if app_defaults.empty?

    results = []
    app_defaults.each do |default_translation|
      result = team_translations.find { |item| item.key == default_translation.key } || default_translation
      results << result
    end
    results
  end

  # searches for a key in team translations. if doesn't exist then return default
  def self.find_or_init_by_key(language_id, team_id, key)
    translation = team_translations_by_lang(language_id, team_id).find_by(key: key)
    return translation if translation
    defaults.find_by(language_id: language_id, key: key)
  end

  # searches for translations associated with the team. does not search for defaults
  def self.team_translations_by_lang(language_id, team_id)
    Team.find(team_id).translations.by_language(language_id)
  rescue ActiveRecord::RecordNotFound
    logger.debug("no team for #{team_id}")
    return []
  end
end
