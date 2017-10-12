# frozen_string_literal: true

class CreateAttachment < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id, index: true
      t.string :attachable_type, index: true
      t.string :file
      t.timestamps
    end
  end
end
