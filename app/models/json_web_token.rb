# frozen_string_literal: true

# This contains logic for encoding and decoding jwt tokens
class JsonWebToken
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode payload, Rails.application.secrets.secret_key_base, "HS256"
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: "HS256")
  end

  # Validates the payload hash for expiration and meta claims
  def self.valid_payload(payload)
    if expired(payload) || payload["iss"] != meta[:iss] || payload["aud"] != meta[:aud]
      logger.debug "valid payload is false"
      false
    else
      true
    end
  end

  # Default options to be encoded in the token
  def self.meta
    {
      exp: 2.days.from_now.to_i,
      iss: "eventfuel",
      aud: "register"
    }
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    #return true if payload["exp"].nil?
    Time.zone.at(payload["exp"]) < Time.current
  end
end
