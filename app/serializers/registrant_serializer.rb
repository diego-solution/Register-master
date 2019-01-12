# frozen_string_literal: true

# serializer for registrants
class RegistrantSerializer < ActiveModel::Serializer
  attributes :id, :referrer_name, :full_name, :email, 
             :serialized_answers, :registration_status, 
             :created_at

  #belongs_to :event
  #belongs_to :team
end
