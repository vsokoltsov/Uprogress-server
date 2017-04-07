# frozen_string_literal: true
class AppointmentWorker
  include Sidekiq::Worker

  def perform(*_args)
    UserMailer.restore_password(User.last, '1111').deliver_now
  end
end
