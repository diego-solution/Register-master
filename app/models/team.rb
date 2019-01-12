# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# accounts on the system
class Team < ApplicationRecord
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships
  has_many :page_contents, dependent: :destroy
  has_many :registrants, dependent: :destroy
  has_many :registration_forms, dependent: :destroy
  has_many :email_templates, dependent: :destroy
  has_many :prepared_emails, dependent: :destroy
  has_many :page_layouts, dependent: :destroy

  has_many :events, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :report_schedules, dependent: :destroy

  has_many :translations, dependent: :destroy

  validates :name, presence: true

  after_create :create_default_groups
  after_create :duplicate_default_layouts
  after_create :create_default_form
  #after_create :create_default_email_templates

  def total_events
    events.count
  end

  def total_groups
    groups.count
  end

  def total_members
    users.count
  end

  private

  def duplicate_default_layouts
    #code
    page_layout = PageLayout.where(is_original: true, team_id: nil)
    page_layout.each do |layout|
      copy_duplicate = layout.dup
      copy_duplicate.team = self
      copy_duplicate.save
    end
  end

  # create a default group associated with this team
  def create_default_groups
    Group.create(name: I18n.t("defaults.group_name"), team: self)
  end

  # add a form for the team
  def create_default_form
    # create registration forms
    form = RegistrationForm.create(team: self, name: "Basic Information", archived: false)

    # create questions for forms
    q = RegistrationQuestion.new(kind: "single", required: true, width: "50%", placeholder: "Pedro", question: "First Name", registration_options: [RegistrationOption.new(option: "First Name")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "single", required: true, width: "50%", placeholder: "Sousa", question: "Last Name", registration_options: [RegistrationOption.new(option: "Last Name")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "email", required: true, question: "E-mail", placeholder: "email@mail.com", registration_options: [RegistrationOption.new(option: "E-mail")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "single", question: "Company Name", registration_options: [RegistrationOption.new(option: "Company Name")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "section", question: "Additional Information")
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "single", question: "Job Title", registration_options: [RegistrationOption.new(option: "Job Title")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "single", placeholder: "Please select an option", question: "Job Function", registration_options: [RegistrationOption.new(option: "Job Function")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "multiple_other", placeholder: "Please select an option", question: "Devices Owned", registration_options: [RegistrationOption.new(option: "iPhone"), RegistrationOption.new(option: "iPad"), RegistrationOption.new(option: "Android"), RegistrationOption.new(option: "Windows Phone")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "multiple", placeholder: "Please select an option", question: "Select food option", registration_options: [RegistrationOption.new(option: "None"), RegistrationOption.new(option: "Halal"), RegistrationOption.new(option: "Vegie")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "tickbox", placeholder: "I Agree to the Terms and Conditions", question: "Accept Terms", registration_options: [RegistrationOption.new(option: "I Agree to the Terms and Conditions")])
    form.registration_questions << q

    q = RegistrationQuestion.new(kind: "text", required: false, question: "Do you have a suggestion?", registration_options: [RegistrationOption.new(option: "Suggestion")])
    form.registration_questions << q
  end

  # TODO: this is in i18n so the following is not used for now
  # create email templates
  # def create_default_email_templates
  #   email1 = EmailTemplate.create(team: t, kind: "registration", name: "Register Template", subject: "Your registration is almost done", content: "Thank you, to finish your registration follow the link below to confirm or cancel.")
  #
  #   email1 = EmailTemplate.create(team: t, kind: "cancel", name: "Cancel Template", subject: "You canceled your registration", content: "Your registration to the event below was canceled.")
  #
  #   email1 = EmailTemplate.create(team: t, kind: "waitlist", name: "Waitlist Template", subject: "Your registration is on hold", content: "Your registration to the event below is on hold until more seats are available.")
  #
  #   email1 = EmailTemplate.create(team: t, kind: "confirmed", name: "Confirmation Template", subject: "Your registration is done", content: "Your registration to the event below is finished.")
  # end
end
