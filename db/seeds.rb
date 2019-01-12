# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create basic languages
def create_languages
  #code
  Language.find_or_create_by(english_name: "English", native_name: "English", key: "en")
  Language.find_or_create_by(english_name: "Spanish", native_name: "Espanol", key: "es_ES")
  Language.find_or_create_by(english_name: "Portuguese", native_name: "Portugues", key: "pt_PT")
  Language.find_or_create_by(english_name: "German", native_name: "Deutsch", key: "de_DE")
  Language.find_or_create_by(english_name: "French", native_name: "Francais", key: "fr_FR")
  Language.find_or_create_by(english_name: "Italian", native_name: "Italiano", key: "it_IT")
  Language.find_or_create_by(english_name: "Dutch", native_name: "Dutch", key: "nl_NL")
  Language.find_or_create_by(english_name: "Polish", native_name: "Polish", key: "pl_PL")
  Language.find_or_create_by(english_name: "Russian", native_name: "Russian", key: "ru_RU")
end

def create_templates
  # create page templates
  # TODO improve this
  # template = PageContent.create(kind: "header", team: t, content: "<h1>Event Name</h1>")
  # template = PageContent.create(kind: "footer", team: t, content: "<p>All rights reserved</p>")
  # template = PageContent.create(kind: "body", team: t, content: "<p>Some info about my event.</p>")
  # template = PageContent.create(kind: "sidebar", team: t, content: "<p>When and how?</p>")

  PageLayout.create(
    name: "Default Template",
    is_original: true,
    disable_sidebar: false,
    header: "<h1>{{event.name}}</h1><h2>{{event.city}}</h2>",
    sidebar: "<h6>Date</h6>
    <p>{{event.start_date}} at {{event.start_time}}</p>
    <h6>Other info</h6>
    <p>{{event.start_time}}</p>
    <h6>Location</h6>
    <p>{{event.location}}</p>",
    body: "<p>Add some text explaining what the event is all about.</p>",
    footer: "<p>© Company 2018 All rights reserved.</p>
    <a href='https://www.eventfuel.io/about/our-mission' class='m-footer__link'>About</a><a href='https://www.eventfuel.io/privacy-policy' class='m-footer__link'>Privacy</a>"
  )
end

def create_team
  t = Team.create(name: "Team Eventfuel")
  users_attrs = [
    { first_name: "Pedro", last_name: "Sousa", email: "psousa@thinkorange.pt" },
    { first_name: "Niko", last_name: "Roberts", email: "niko@tasboa.com" }
  ]
  users_attrs.each do |user_attr|
    u = User.new(user_attr)
    u.password = "teste12345"
    u.password_confirmation = "teste12345"
    u.save
    TeamMembership.create(user: u, team: t, admin: true)
  end
  t
end

# #1
#create_languages if Language.all.count == 0

# # 2
# create_templates if PageLayout.count == 0

# #3 create a default team & users
t = create_team

# # create some groups
# Group.create(name: "Portugal", team: t)

# # create a dummy event
# # status, at_capacity_action, header, footer and registration content
# event1 = Event.create(
#   team: t,
#   group: t.groups.first,
#   language: Language.first,
#   registration_form: t.registration_forms.first,
#   page_layout: t.page_layouts.first,
#   public_name: "My little Event",
#   city: "Lisbon",
#   country: "Portugal",
#   start_date: Time.zone.now + 1.day,
#   registration_close_date: Time.zone.now + 3.days,
#   at_capacity_action: "stop",
#   capacity: 20,
#   location: "LX Factory 78, 1300"
# )

# event1 = Event.create(
#   team: t,
#   group: t.groups.last,
#   language: Language.first,
#   registration_form: t.registration_forms.first,
#   page_layout: t.page_layouts.first,
#   public_name: "My big Event",
#   city: "Melbourne",
#   country: "Australia",
#   start_date: Time.zone.now + 1.day,
#   registration_close_date: Time.zone.now + 3.days,
#   at_capacity_action: "stop",
#   capacity: 20,
#   location: "LX Factory 78, 1300"
# )

def create_en_translations(first)
  puts "creating english translations"
  Translation.create(namespace: "Messages", key: "registration.success.title", text: "Your information was submitted", language: first)
  Translation.create(namespace: "Messages", key: "registration.success.message", text: "Thank you for registering, you will receive an email to confirm your attendance.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.title", text: "We couldn't submit your registration", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.message", text: "There was a unexpected error while processing your information. Please try again.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.missing_information", text: "Some information is required, please review the form and submit again.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.full", text: "I'm sorry but the event reached full capacity. There is no more space.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.closed", text: "The event you are looking for is over, see you in the next one.", language: first)
  Translation.create(namespace: "Share", key: "registration.calendar.title", text: "Add to calendar", language: first)
  Translation.create(namespace: "Share", key: "registration.map.title", text: "View on map", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.title", text: "Event Registation Form", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.button", text: "Submit", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist", text: "The event is full but you can submit anyway and we'll add you to a waitlist.", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist_submitted", text: "Your details have been added to the waitlist. You will receive a confirmation email if a space becomes available.", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.full", text: "This event is completely full. No new registrations are being accepted.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.text", text: "Thanks for your participation! If your plans change and you cannot visit the event, please reject your registration with the button below.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.confirmed", text: "You are confirmed.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.canceled", text: "You've canceled the registration for the event.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.error", text: "There was an error submitting your confirmation data. Please try again.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.already", text: "You've already finished your registration for the event.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.confirm", text: "Confirm", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.decline", text: "Decline", language: first)
end


english = Language.find_by(key: "en")
create_en_translations(english) if Translation.where(language: english).count.zero?

def create_ru_translations(first)
  puts "creating russian translations"
  Translation.create(namespace: "Messages", key: "registration.success.title", text: "Ваша заявка отправлена", language: first)
  Translation.create(namespace: "Messages", key: "registration.success.message", text: "Спасибо за Вашу заявку. Мы отправили письмо на Ваш email. Пожалуйста, подтвердите Вашу заявку, нажав на кнопку в письме.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.title", text: "Не удалось создать заявку", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.message", text: "Произошла непредвиденная ошибка при обработке информации. Пожалуйста, попробуйте еще раз.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.missing_information", text: "Не все обязательные поля заполнены. Пожалуйста, заполните их и отправьте заявку снова.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.full", text: "К сожалению нет свободных мест.", language: first)
  Translation.create(namespace: "Messages", key: "registration.error.closed", text: "Мероприятие, которое вы ищите, завершилось.", language: first)
  Translation.create(namespace: "Share", key: "registration.calendar.title", text: "Добавить в Календарь", language: first)
  Translation.create(namespace: "Share", key: "registration.map.title", text: "Посмотреть на карте", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.title", text: "Форма регистрации на мероприятие", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.button", text: "Отправить", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist", text: "К сожалению нет свободных мест, но мы можем принять вашу заявку в список ожидания.", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.full", text: "К сожалению нет свободных мест на мероприятии. Мы не можем принять новые заявки.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.text", text: "Спасибо за подтверждение Вашего участия! Если у Вас изменятся планы и Вы не сможете присутствовать на Бизнес-утре, пожалуйста, отмените Вашу регистрацию, нажав кнопку ниже.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.confirmed", text: "Вы зарегистрированы на мероприятие. До скорой встречи!", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.canceled", text: "Вы отменили вашу заявку на мероприятие.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.error", text: "Произошла ошибка при подтверждении вашего участия. Пожалуйста, попробуйте еще раз.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.already", text: "Вы уже подали заявку на это мероприятие.", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.confirm", text: "Подтвердить", language: first)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.decline", text: "Отменить", language: first)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist_submitted", text: "Your details have been added to the waitlist. You will receive a confirmation email if a space becomes available.", language: first)
end

ruski = Language.find_by(key: "ru_RU")
create_ru_translations(ruski) if Translation.where(language: ruski).count.zero?

def add_unsuported_browser_msg
  english = Language.find_by(key: "en")
  Translation.create(namespace: "Registration", key: "registration.error.browser",
                   text: "Your current web browser version is not supported. Please try a more modern version, like IE Edge or other browser.",
                   language: english) if Translation.where(language: english, key: "registration.error.browser").count.zero?

  ruski = Language.find_by(key: "ru_RU")
  if Translation.where(language: ruski, key: "registration.error.browser").count.zero?
    Translation.create(namespace: "Registration", key: "registration.error.browser",
                       text: "Текущая версия веб-браузера не поддерживается. Используйте современную версию, например IE Edge, или попробуйте другой браузер.",
                       language: ruski)
  end
end

add_unsuported_browser_msg


# # this is a default template in case we need to add complete translations for a language, just change the text inside the text: symbol
# def add_new_language_translations(language)
#   Translation.create(namespace: "Messages", key: "registration.success.title", text: "Your information was submitted", language: language)
#   Translation.create(namespace: "Messages", key: "registration.success.message", text: "Thank you for registering, you will receive an email to confirm your attendance.", language: language)
#   Translation.create(namespace: "Messages", key: "registration.error.title", text: "We couldn't submit your registration", language: language)
#   Translation.create(namespace: "Messages", key: "registration.error.message", text: "There was a unexpected error while processing your information. Please try again.", language: language)
#   Translation.create(namespace: "Messages", key: "registration.error.missing_information", text: "Some information is required, please review the form and submit again.", language: language)
#   Translation.create(namespace: "Messages", key: "registration.error.full", text: "I'm sorry but the event reached full capacity. There is no more space.", language: language)
#   Translation.create(namespace: "Messages", key: "registration.error.closed", text: "The event you are looking for is over, see you in the next one.", language: language)
#   Translation.create(namespace: "Share", key: "registration.calendar.title", text: "Add to calendar", language: language)
#   Translation.create(namespace: "Share", key: "registration.map.title", text: "View on map", language: language)
#   Translation.create(namespace: "Registration", key: "registration.form.title", text: "Event Registation Form", language: language)
#   Translation.create(namespace: "Registration", key: "registration.form.button", text: "Submit", language: language)
#   Translation.create(namespace: "Registration", key: "registration.form.waitlist", text: "The event is full but you can submit anyway and we'll add you to a waitlist.", language: language)
#   Translation.create(namespace: "Registration", key: "registration.form.waitlist_submitted", text: "Your details have been added to the waitlist. You will receive a confirmation email if a space becomes available.", language: language)
#   Translation.create(namespace: "Registration", key: "registration.form.full", text: "This event is completely full. No new registrations are being accepted.", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.form.text", text: "Thanks for your participation! If your plans change and you cannot visit the event, please reject your registration with the button below.", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.form.confirmed", text: "You are confirmed.", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.form.canceled", text: "You've canceled the registration for the event.", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.form.error", text: "There was an error submitting your confirmation data. Please try again.", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.form.already", text: "You've already finished your registration for the event.", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.button.confirm", text: "Confirm", language: language)
#   Translation.create(namespace: "Confirmation", key: "confirmation.button.decline", text: "Decline", language: language)
#   Translation.create(namespace: "Registration", key: "registration.error.browser",
#                    text: "Your current web browser version is not supported. Please try a more modern version, like IE Edge or other browser.",
#                    language: english)
# end

def create_da_translations(language)
  puts "creating danish"
  Translation.create(namespace: "Messages", key: "registration.success.title", text: "Dine oplysninger blev indsendt", language: language)
  Translation.create(namespace: "Messages", key: "registration.success.message", text: "Tak fordi du har registreret, vil du modtage en email for at bekræfte din deltagelse.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.title", text: "Vi kunne ikke sende din registrering", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.message", text: "Der opstod en uventet fejl under behandlingen af dine oplysninger. Prøv igen.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.missing_information", text: "Nogle oplysninger er nødvendige, bedes du gennemse formularen og indsende igen.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.full", text: "Vi beklager, men arrangementet nåede fuld kapacitet. Der er ikke mere plads.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.closed", text: "Den begivenhed, du leder efter, er forbi, vi ses i den næste.", language: language)
  Translation.create(namespace: "Share", key: "registration.calendar.title", text: "Tilføj til kalender", language: language)
  Translation.create(namespace: "Share", key: "registration.map.title", text: "Vis på kort", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.title", text: "Hændelsesregistreringsformular", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.button", text: "Indsend", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist", text: "Arrangementet er fuldt, men du kan indsende alligevel, og vi føjer dig til en venteliste.", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist_submitted", text: "Dine oplysninger er blevet tilføjet til ventelisten. Du modtager en bekræftelses-email, hvis et mellemrum bliver tilgængeligt.", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.full", text: "Denne begivenhed er helt fuld. Ingen nye registreringer accepteres.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.text", text: "Tak for din deltagelse! Hvis dine planer ændres, og du ikke kan besøge arrangementet, skal du afvise din registrering med knappen nedenfor.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.confirmed", text: "Du er bekræftet.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.canceled", text: "Du har annulleret registreringen for arrangementet.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.error", text: "Der opstod en fejl under indsendelse af dine bekræftelsesdata. Prøv igen.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.already", text: "Du har allerede afsluttet din registrering til arrangementet.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.confirm", text: "Bekræfte", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.decline", text: "Nedgang", language: language)
  Translation.create(namespace: "Registration", key: "registration.error.browser",
                  text: "
Din nuværende webbrowser-version understøttes ikke. Prøv venligst en mere moderne version, som f.eks. IE Edge eller en anden browser.",
                  language: language)
end 


danish =   Language.find_or_create_by(english_name: "Danish", native_name: "Danish", key: "da_DK")
create_da_translations(danish) if Translation.where(language: danish).count.zero?
 


# # this is a default template in case we need to add complete translations for a language, just change the text inside the text: symbol
def add_german_translations(language)
  puts "creating german translations"
  Translation.create(namespace: "Messages", key: "registration.success.title", text: "Ihre Informationen wurden übermittelt", language: language)
  Translation.create(namespace: "Messages", key: "registration.success.message", text: "Vielen Dank für die Registrierung. Sie erhalten eine E-Mail, um Ihre Teilnahme zu bestätigen.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.title", text: "Wir konnten Ihre Registrierung nicht übermitteln", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.message", text: "Bei der Verarbeitung Ihrer Daten ist ein unerwarteter Fehler aufgetreten. Bitte versuche es erneut.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.missing_information", text: "Einige Informationen sind erforderlich, überprüfen Sie das Formular und senden Sie es erneut.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.full", text: "Es tut mir leid, aber das Event hat die volle Kapazität erreicht. Es gibt keinen Platz mehr.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.closed", text: "Das gesuchte Ereignis ist vorbei, bis zum nächsten.", language: language)
  Translation.create(namespace: "Share", key: "registration.calendar.title", text: "Zum Kalender hinzufügen", language: language)
  Translation.create(namespace: "Share", key: "registration.map.title", text: "Auf der Karte anzeigen", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.title", text: "Ereignisregistrierungsformular", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.button", text: "einreichen", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist", text: "Das Event ist voll, aber Sie können es trotzdem absenden und wir werden Sie zu einer Warteliste hinzufügen.", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist_submitted", text: "Ihre Angaben wurden zur Warteliste hinzugefügt. Sie erhalten eine Bestätigungs-E-Mail, sobald ein Platz verfügbar ist.", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.full", text: "Diese Veranstaltung ist komplett gefüllt. Es werden keine neuen Registrierungen akzeptiert.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.text", text: "Danke für Ihre Teilnahme! Wenn sich Ihre Pläne ändern und Sie die Veranstaltung nicht besuchen können, lehnen Sie Ihre Registrierung mit dem folgenden Button ab.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.confirmed", text: "Sie sind bestätigt.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.canceled", text: "Sie haben die Registrierung für das Ereignis abgebrochen.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.error", text: "Beim Senden Ihrer Bestätigungsdaten ist ein Fehler aufgetreten. Bitte versuche es erneut.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.already", text: "Sie haben Ihre Registrierung für die Veranstaltung bereits abgeschlossen.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.confirm", text: "Bestätigen", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.decline", text: "Ablehnen", language: language)
  Translation.create(namespace: "Registration", key: "registration.error.browser",
                   text: "Ihre aktuelle Browserversion wird nicht unterstützt. Bitte versuchen Sie eine modernere Version, wie IE Edge oder andere Browser.",
                   language: language)
end

german =   Language.find_or_create_by(english_name: "German", native_name: "Deutsch", key: "de_DE")
add_german_translations(german) if Translation.where(language: german).count.zero?
 


# this is a default template in case we need to add complete translations for a language, just change the text inside the text: symbol
def add_franch_translation(language)
  puts "oohh lá lá"
  Translation.create(namespace: "Messages", key: "registration.success.title", text: "Vos informations ont été soumises", language: language)
  Translation.create(namespace: "Messages", key: "registration.success.message", text: "Merci de votre inscription, vous recevrez un email pour confirmer votre présence.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.title", text: "Nous n'avons pas pu soumettre votre inscription", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.message", text: "Une erreur inattendue s'est produite lors du traitement de vos informations. Veuillez réessayer.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.missing_information", text: "Certaines informations sont requises, veuillez consulter le formulaire et le soumettre à nouveau.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.full", text: "Je suis désolé mais l'événement a atteint sa pleine capacité. Il n'y a plus d'espace.", language: language)
  Translation.create(namespace: "Messages", key: "registration.error.closed", text: "L'événement que vous cherchez est terminé, à la prochaine.", language: language)
  Translation.create(namespace: "Share", key: "registration.calendar.title", text: "Ajouter au calendrier", language: language)
  Translation.create(namespace: "Share", key: "registration.map.title", text: "Voir sur la carte", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.title", text: "Formulaire d'enregistrement d'événement", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.button", text: "Soumettre", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist", text: "L'événement est complet mais vous pouvez le soumettre de toute façon et nous vous ajouterons à une liste d'attente.", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.waitlist_submitted", text: "Vos coordonnées ont été ajoutées à la liste d'attente. Vous recevrez un email de confirmation si un espace devient disponible.", language: language)
  Translation.create(namespace: "Registration", key: "registration.form.full", text: "Cet événement est complètement complet. Aucune nouvelle inscription n'est acceptée.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.text", text: "Merci pour votre participation! Si vos plans changent et que vous ne pouvez pas participer à l'événement, veuillez refuser votre inscription avec le bouton ci-dessous.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.confirmed", text: "Vous êtes confirmé", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.canceled", text: "Vous avez annulé l'inscription à l'événement.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.error", text: "Une erreur s'est produite lors de la soumission de vos données de confirmation. Veuillez réessayer.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.form.already", text: "Vous avez déjà terminé votre inscription pour l'événement.", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.confirm", text: "Confirmer", language: language)
  Translation.create(namespace: "Confirmation", key: "confirmation.button.decline", text: "Déclin", language: language)
  Translation.create(namespace: "Registration", key: "registration.error.browser",
                   text: "Votre version actuelle du navigateur Web n'est pas prise en charge. S'il vous plaît essayez une version plus moderne, comme IE Edge ou un autre navigateur.",
                   language: language)
end

le_french = Language.find_or_create_by(english_name: "French", native_name: "Francais", key: "fr_FR")
add_franch_translation(le_french) if Translation.where(language: le_french).count.zero?
 
