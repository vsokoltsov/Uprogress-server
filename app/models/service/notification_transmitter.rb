# frozen_string_literal: true
class Service::NotificationTransmitter
  def send_appointments
    appointments_scope.each do |appointment|
      klass = appointment.repeats_to_class_name
      appointment_sender = "Service::Appointment::#{klass}".constantize
                                                           .new(appointment)
      appointment_sender.send_notification
    end
  end

  private

  def appointments_scope
    time_from = (Time.zone.now - 5.minutes).strftime('%H:%M:%S %z')
    time_to = (Time.zone.now + 5.minutes).strftime('%H:%M:%S %z')
    Appointment.where('date::time >= ? and date::time <= ? and available=true',
                      time_from, time_to)
  end
end
