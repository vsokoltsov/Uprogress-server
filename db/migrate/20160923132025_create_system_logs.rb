# frozen_string_literal: true
class CreateSystemLogs < ActiveRecord::Migration
  def change
    create_table :system_logs do |t|
      t.belongs_to :user
      t.integer :operation
      t.jsonb :data, default: '{}'
      t.timestamps
    end
    add_index :system_logs, :data, using: :gin
  end
end
