# frozen_string_literal: true
class AddResetPasswordTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reset_password_token, :text
  end
end
