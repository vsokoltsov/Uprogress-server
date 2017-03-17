# frozen_string_literal: true
class DefaultMailer < ActionMailer::Base
  default from: 'from@example.com'

  def test_mail
    mail to: 'vforvad@gmail.com'
  end
end
