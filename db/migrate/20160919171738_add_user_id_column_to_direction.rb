# frozen_string_literal: true
class AddUserIdColumnToDirection < ActiveRecord::Migration
  def change
    add_reference :directions, :user, index: true
  end
end
