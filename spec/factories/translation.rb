# frozen_string_literal: true

FactoryBot.define do
  factory :translate_1, class: "Translation" do
    namespace "forms"
    key "reg.one"
    text "One"
    association :language, factory: :language, strategy: :build
    association :team, factory: :team, strategy: :build
  end

  factory :translate_2, class: "Translation" do
    namespace "forms"
    key "reg.two"
    text "Two"
    association :language, factory: :language, strategy: :build
    association :team, factory: :team, strategy: :build
  end

  factory :default_translate_1, class: "Translation" do
    namespace "forms"
    key "reg.one"
    text "One"
    association :language, factory: :language, strategy: :build
  end

  factory :default_translate_2, class: "Translation" do
    namespace "forms"
    key "reg.two"
    text "Something in Klingon"
    association :language, factory: :language_klingon, strategy: :build
  end

  factory :default_translate_3, class: "Translation" do
    namespace "forms"
    key "reg.three"
    text "Three"
    association :language, factory: :language, strategy: :build
  end
end
