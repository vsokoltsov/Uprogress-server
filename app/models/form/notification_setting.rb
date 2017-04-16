class Form::NotificationSetting < Form::Base
  attribute :push_enabled
  attribute :mail_enabled

  validates :push_enabled, :mail_enabled, presence: true
end
