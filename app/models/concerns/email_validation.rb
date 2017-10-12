# frozen_string_literal: true

module EmailValidation
  extend ActiveSupport::Concern

  included do
    VALID_EMAIL_REGEX = /\b[[:alnum:]._%a-z\-]+@(?:[[:alnum:]\-]+\.)+[[:alpha:]]{2,}\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  end
end
