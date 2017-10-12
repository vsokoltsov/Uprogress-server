# frozen_string_literal: true

class CreateDeviceTable < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.belongs_to :authorization, index: true, null: false
      t.text :token, null: false
      t.timestamps
    end
  end
end
