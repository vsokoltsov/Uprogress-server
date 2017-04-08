# frozen_string_literal: true
class Service::Appointment::Never < Service::Appointment::Base

  def send_notification
    super do
      appointment.update!(available: false) if appointment.never?
    end
  end
end
