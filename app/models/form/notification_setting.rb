class Form::NotificationSetting < Form::Base
  attribute :push_enabled, :Boolean
  attribute :mail_enabled, :Boolean

  validates :push_enabled, :mail_enabled, inclusion: { in: [ true, false ] }
end
