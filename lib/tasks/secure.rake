# frozen_string_literal: true

# assorted tasks
namespace :eventfuel do
  task migrate_registrant_data: :environment  do
    Registrant.all.each do |p|
      p.update_attributes!(email: p.plain_email, serialized_answers: p.plain_serialized_answers)
    end
  end
  task migrate_user_data: :environment  do
    User.all.each do |p|
      p.update_attributes!(first_name: p.plain_first_name, last_name: p.plain_last_name)
    end
  end
end