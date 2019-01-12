# frozen_string_literal: true

FactoryBot.define do
  factory :language, class: "Language" do
    english_name "English"
    native_name "English"
    key  "en"
  end
  factory :language_klingon, class: "Language" do
    english_name "Klingon"
    native_name "Klingon"
    key  "tlh"
  end
end
