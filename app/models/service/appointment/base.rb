# frozen_string_literal: true
class Service::Appointment::Base
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
end
