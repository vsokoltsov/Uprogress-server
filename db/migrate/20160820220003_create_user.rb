# frozen_string_literal: true
class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :nick, index: true, null: false
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
