# frozen_string_literal: true
class CreateSystemLogs < ActiveRecord::Migration
  def change
    create_table :system_logs do |t|
      t.belongs_to :user, null: false
      t.string :operation, index: true, null: false
      t.jsonb :data, default: '{}', null: false
      t.timestamps
    end
    add_index :system_logs, :data, using: :gin
  end
end
