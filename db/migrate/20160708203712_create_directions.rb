# frozen_string_literal: true
class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :title, index: true, null: false
      t.text :description, index: true, null: false
      t.timestamps
    end
  end
end
