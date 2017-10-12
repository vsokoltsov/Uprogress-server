# frozen_string_literal: true

module PasswordValidation
  extend ActiveSupport::Concern

  included do
    validates :password, presence: true
    validates :password, length: { minimum: 6 }
  end
end
