# frozen_string_literal: true
class Service::NotificationTransmitter
  def send_appointments
    appointmets_scope.each do |appointment|
      direction = appointment.direction
      user = direction.user
      send_to_user(user, direction, appointment)
    end
  end

  private

  def send_to_user(user, direction, appointment)
    return unless appointment.available?
    message = prepare_text(direction, appointment)
    user.send_notification(message[:body], message[:title])
    appointment.update!(available: false) if appointment.never?
  end

  def prepare_text(direction, appointment)
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

  def appointments_scope
    time_from = (Time.zone.now - 5.minutes).strftime('%H:%M:%S %z')
    time_to = (Time.zone.now + 5.minutes).strftime('%H:%M:%S %z')
    Appointment.where('date::time >= ? and date::time <= ? and available=true', time_from, time_to)
  end
end
