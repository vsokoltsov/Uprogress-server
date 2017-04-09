# frozen_string_literal: true
class Service::Appointment::Base
  attr_accessor :user, :direction, :appointment

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validate :appointment_available?
  validate :start_date_valid?

  def initialize(appointment)
    @appointment = appointment
    @direction = appointment.direction
    @user = direction.user
  end

  def send_notification
    return unless valid?
    message = prepare_text
    user.send_notification(message[:body], message[:title])
    yield if block_given?
  end

  private

  def prepare_text
    message = {}
    default_title = 'Scheduled appointment'
    direction_name = "#{direction.title} - #{appointment.date.to_formatted_s(:short)}"

    if appointment.message.present?
      message[:title] = direction_name
      message[:body] = appointment.message
    else
      message[:title] = default_title
      message[:body] = direction_name
    end
    message
  end

  def appointment_available?
    appointment.available?
  end

  def start_date_valid?
    appointment.start_date_valid?
  end
end
