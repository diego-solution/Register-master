# frozen_string_literal: true

RSpec.describe Translation, type: :model do
  let!(:language) { FactoryBot.create :language }
  let!(:team) { FactoryBot.create :team }
  let!(:df_tr1) { FactoryBot.create :default_translate_1, language: language }
  let!(:df_tr2) { FactoryBot.create :default_translate_2 }
  let!(:df_tr3) { FactoryBot.create :default_translate_3, language: language }
  let(:tr1) { FactoryBot.create :translate_1, language: language, team: team }
  let(:tr2) { FactoryBot.create :translate_2, language: language, team: team }

  context ".find_or_init_by_key" do
    it "should return existing translation" do
      tr1.save
      result = Translation.find_or_init_by_key(language.id, team.id, df_tr1.key)
      expect(result).to eq tr1
    end

    it "should return default translation if none exist" do
      result = Translation.find_or_init_by_key(language.id, team.id, df_tr1.key)
      expect(result).to eq df_tr1
    end

    it "should return nil if invalid key" do
      result = Translation.find_or_init_by_key(language.id, team.id, "notexist")
      expect(result).to eq nil
    end
  end

  context ".mixed_content_for_team" do
    it "should return total translations if no team exists" do
      results = Translation.mixed_content_for_team(language.id, 333)
      expect(results.size).to eq 2
    end

    it "should return default translations if no saved content exists" do
      results = Translation.mixed_content_for_team(language.id, team.id)

      expect(results.first.text).to eq df_tr1.text
      expect(results.size).to eq 2
    end

    it "should return saved translations and missing translations" do
      tr1.save
      results = Translation.mixed_content_for_team(language.id, team.id)

      expect(results.size).to eq 2
      expect(results.first.text).to eq tr1.text
      expect(results.last.text).to eq df_tr3.text
    end

    it "should return correct translations for language" do
      tr1.save
      results = Translation.mixed_content_for_team(Language.last.id, team.id)

      expect(results.size).to eq 1
    end

    it "should return default translations in english if translations exist in klingon?" do
      skip "TODO: Define if this is the behaviour?"
      df_tr2.destroy

      results = Translation.mixed_content_for_team(Language.last.id, team.id)
      expect(results.first.text).to eq df_tr1.text
      expect(results.size).to eq 2
    end
  end
end
