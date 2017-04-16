# frozen_string_literal: true
class NotificationSetting < ActiveRecord::Base
  belongs_to :user
end
