# frozen_string_literal: true

# serializer for teams
class TranslationSerializer < ActiveModel::Serializer
  attributes :id, :key, :cenas, :language_id, :namespace, :team_id, :text  #, :total_events, :total_members
end
