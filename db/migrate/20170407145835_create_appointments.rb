# frozen_string_literal: true
class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :direction, null: false, index: true
      t.datetime :date, null: false
      t.integer :repeats, null: false, index: true
      t.text :message
      t.boolean :available, index: true, default: true
      t.timestamps
    end
  end
end
