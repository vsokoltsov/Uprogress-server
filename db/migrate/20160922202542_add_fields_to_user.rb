# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, index: true
    add_column :users, :last_name, :string, index: true
    add_column :users, :description, :text
  end
end
