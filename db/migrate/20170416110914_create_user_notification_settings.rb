# frozen_string_literal: true

class CreateUserNotificationSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_settings do |t|
      t.belongs_to :user, index: true, null: false
      t.boolean :push_enabled, default: true, null: false
      t.boolean :mail_enabled, default: true, null: false
      t.timestamps
    end
  end
end
