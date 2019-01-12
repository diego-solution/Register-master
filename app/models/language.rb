# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id           :integer          not null, primary key
#  english_name :string
#  native_name  :string
#  key          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# available languages to localise an event for
class Language < ApplicationRecord
  validates :english_name, :key, presence: true, uniqueness: true
  has_many :events, dependent: :nullify

  def name
    english_name
  end 

  def self.fix_invalid_locales
    RegistrationQuestion.all.each do |question|

      if question.question_translations.present? && question.question_translations["en_EN"]
        if question.question_translations["en"].nil?
          question.question_translations["en"] = question.question_translations.delete "en_EN"
        else 
          question.question_translations.delete "en_EN"
        end
      end

      if question.placeholder_translations.present? && question.placeholder_translations["en_EN"]
        if question.placeholder_translations["en"].nil?
          question.placeholder_translations["en"] = question.placeholder_translations.delete "en_EN"
        else 
          question.placeholder_translations.delete "en_EN"
        end
      end

      if question.help_text_translations.present? && question.help_text_translations["en_EN"]
        if question.help_text_translations["en"].nil?
          question.help_text_translations["en"] = question.help_text_translations.delete "en_EN"
        else 
          question.help_text_translations.delete "en_EN"
        end
      end

      question.save
    end

    RegistrationOption.all.each do |option|
      if option.option_translations.present? && option.option_translations["en_EN"]
        if option.option_translations["en"].nil?
          option.option_translations["en"] = option.option_translations.delete "en_EN"
        else 
          option.option_translations.delete "en_EN"
        end
      end
      option.save
    end


    p = Language.find_by key: "en_EN"
    return if p.nil?
    p.key = "en"
    p.save
  end

end
