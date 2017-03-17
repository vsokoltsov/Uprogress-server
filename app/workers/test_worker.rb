# frozen_string_literal: true
class TestWorker
  include Sidekiq::Worker

  def perform(*_args)
    ::DefaultMailer.test_mail.deliver
  end
end
