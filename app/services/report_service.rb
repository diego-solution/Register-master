# frozen_string_literal: true

# Export the registrants and event into something ground control accepts
class ReportService
  def initialize(params)
    @event = params[:event]
    @registrants = params[:registrants]
  end

  def export
    records = []
    # get questions
    records << questions

    # get answers
    @registrants.each do |reg|
      answer = [reg.event.internal_name, reg.registration_status]
      reg.serialized_answers.each do |value|
        answer << value["value"]
      end
      records << answer
    end
    records
  end

  private

  def questions
    #code
    questions = ["Event Internal Name", "Registration Status"]
    @event.registration_form.registration_questions.each do |question|
      questions << question.question
    end
    questions
  end
end
