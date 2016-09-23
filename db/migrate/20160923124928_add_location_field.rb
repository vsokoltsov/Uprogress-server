# frozen_string_literal: true
class AddLocationField < ActiveRecord::Migration
  def change
    add_column :users, :location, :string, index: true
  end
end
