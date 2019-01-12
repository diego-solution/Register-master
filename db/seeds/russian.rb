# create registration forms
form = RegistrationForm.create(team: Team.first, name: "BEP Testing", archived: false)

# create questions for forms
f = { "en": "First Name", ru_RU: "Имя" }
q = RegistrationQuestion.new(kind: "single", required: true, width: "50%", placeholder_translations: { en: "John", ru_RU: ""}, question_translations: f, registration_options: [RegistrationOption.new(option_translations: f)])
form.registration_questions << q

f = { "en": "Last Name", ru_RU: "Фамилия" }
q = RegistrationQuestion.new(kind: "single", required: true, width: "50%", placeholder_translations: { en: "Appleseed", ru_RU: ""}, question_translations: f, registration_options: [RegistrationOption.new(option_translations: f)])
form.registration_questions << q

f = { "en": "Email", ru_RU: "E-mail" }
q = RegistrationQuestion.new(kind: "email", required: true, placeholder_translations: { en: "example@mail.com", ru_RU: ""}, question_translations: f, registration_options: [RegistrationOption.new(option_translations: f)])
form.registration_questions << q

f = { "en": "Company Name", ru_RU: "Название компании" }
q = RegistrationQuestion.new(kind: "single", required: true, placeholder_translations: { en: "", ru_RU: ""}, question_translations: f, registration_options: [RegistrationOption.new(option_translations: f)])
form.registration_questions << q


f = { "en": "Job Title", ru_RU: "Должность" }
q = RegistrationQuestion.new(kind: "single", required: true, placeholder_translations: { en: "", ru_RU: ""}, question_translations: f, registration_options: [RegistrationOption.new(option_translations: f)])
form.registration_questions << q

q = RegistrationQuestion.new(kind: "multiple", placeholder_translations: { en: "", ru_RU: ""}, question_translations: { en: "Industry", ru_RU: "Индустрия"}, registration_options: [
  RegistrationOption.new(option_translations: { en: "Hotels", ru_RU: "Гостиницы" }),
  RegistrationOption.new(option_translations: { en: "Public service", ru_RU: "Государственная служба" }),
  RegistrationOption.new(option_translations: { en: "Resources", ru_RU: "Добыча природных ресурсов" }),
  RegistrationOption.new(option_translations: { en: "Logistics", ru_RU: "Логистика" }),
  RegistrationOption.new(option_translations: { en: "Medicine", ru_RU: "Медицина" }),
  RegistrationOption.new(option_translations: { en: "Education", ru_RU: "Образование" }),
  RegistrationOption.new(option_translations: { en: "Industry", ru_RU: "Промышленность" }),
  RegistrationOption.new(option_translations: { en: "Restaurants, cafes", ru_RU: "Рестораны, кафе" }),
  RegistrationOption.new(option_translations: { en: "Retail", ru_RU: "Розничная торговля" }),
  RegistrationOption.new(option_translations: { en: "Telecommunications", ru_RU: "Телекоммуникации" }),
  RegistrationOption.new(option_translations: { en: "Transport", ru_RU: "Транспорт" }),
  RegistrationOption.new(option_translations: { en: "Beauty services", ru_RU: "Услуги красоты" }),
  RegistrationOption.new(option_translations: { en: "Finance/Insurance", ru_RU: "Финансы, страхование" }),
  RegistrationOption.new(option_translations: { en: "E-commerce", ru_RU: "Электронная коммерция" }),
  RegistrationOption.new(option_translations: { en: "Other", ru_RU: "Другое" })
])
form.registration_questions << q


I18n.with_locale("ru_RU") do
  RegistrationOption.where("option_translations ->> 'en' = 'Hotels'").each { |o| o.update(option: "Гостиницы") }
  RegistrationOption.where("option_translations ->> 'en' = 'Public service'").each { |o| o.update(option: "Государственная служба") }
  RegistrationOption.where("option_translations ->> 'en' = 'Resources'").each { |o| o.update(option: "Добыча природных ресурсов") }
  RegistrationOption.where("option_translations ->> 'en' = 'Logistics'").each { |o| o.update(option: "Логистика") }
  RegistrationOption.where("option_translations ->> 'en' = 'Medicine'").each { |o| o.update(option: "Медицина") }
  RegistrationOption.where("option_translations ->> 'en' = 'Education'").each { |o| o.update(option: "Образование") }
  RegistrationOption.where("option_translations ->> 'en' = 'Industry'").each { |o| o.update(option: "Промышленность") }
  RegistrationOption.where("option_translations ->> 'en' = 'Restaurants, cafes'").each { |o| o.update(option: "Рестораны, кафе") }
  RegistrationOption.where("option_translations ->> 'en' = 'Retail'").each { |o| o.update(option: "Розничная торговля") }
  RegistrationOption.where("option_translations ->> 'en' = 'Telecommunications'").each { |o| o.update(option: "Телекоммуникации") }
  RegistrationOption.where("option_translations ->> 'en' = 'Transport'").each { |o| o.update(option: "Транспорт") }
  RegistrationOption.where("option_translations ->> 'en' = 'Beauty services'").each { |o| o.update(option: "Услуги красоты") }
  RegistrationOption.where("option_translations ->> 'en' = 'Finance, Insurance'").each { |o| o.update(option: "Финансы, страхование") }
  RegistrationOption.where("option_translations ->> 'en' = 'E-commerce'").each { |o| o.update(option: "Электронная коммерция") }
  RegistrationOption.where("option_translations ->> 'en' = 'Other'").each { |o| o.update(option: "Другое") }
end

I18n.with_locale("ru_RU") do
  RegistrationOption.where("option_translations ->> 'en' = 'Hotels'").each { |o| o.update(option: "Гостиницы") }
  RegistrationOption.where("option_translations ->> 'en' = 'Public service'").each { |o| o.update(option: "Государственная служба") }
  RegistrationOption.where("option_translations ->> 'en' = 'Resources'").each { |o| o.update(option: "Добыча природных ресурсов") }
  RegistrationOption.where("option_translations ->> 'en' = 'Logistics'").each { |o| o.update(option: "Логистика") }
  RegistrationOption.where("option_translations ->> 'en' = 'Medicine'").each { |o| o.update(option: "Медицина") }
  RegistrationOption.where("option_translations ->> 'en' = 'Education'").each { |o| o.update(option: "Образование") }
  RegistrationOption.where("option_translations ->> 'en' = 'Industry'").each { |o| o.update(option: "Промышленность") }
  RegistrationOption.where("option_translations ->> 'en' = 'Restaurants, cafes'").each { |o| o.update(option: "Рестораны, кафе") }
  RegistrationOption.where("option_translations ->> 'en' = 'Retail'").each { |o| o.update(option: "Розничная торговля") }
  RegistrationOption.where("option_translations ->> 'en' = 'Telecommunications'").each { |o| o.update(option: "Телекоммуникации") }
  RegistrationOption.where("option_translations ->> 'en' = 'Transport'").each { |o| o.update(option: "Транспорт") }
  RegistrationOption.where("option_translations ->> 'en' = 'Beauty services'").each { |o| o.update(option: "Услуги красоты") }
  RegistrationOption.where("option_translations ->> 'en' = 'Finance, Insurance'").each { |o| o.update(option: "Финансы, страхование") }
  RegistrationOption.where("option_translations ->> 'en' = 'E-commerce'").each { |o| o.update(option: "Электронная коммерция") }
  RegistrationOption.where("option_translations ->> 'en' = 'Other'").each { |o| o.update(option: "Другое") }
end
