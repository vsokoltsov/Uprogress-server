# frozen_string_literal: true

class AppointmentWorker
  include Sidekiq::Worker

  def perform(*_args)
    Service::NotificationTransmitter.new.send_appointments
  end
end
