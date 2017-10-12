# frozen_string_literal: true

class CreateAuthorization < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :user, index: true
      t.string :provider, index: true
      t.string :platform
      t.string :platform_version
      t.string :app_name
      t.string :app_version
      t.datetime :last_sign_in_at, index: true
      t.timestamps
    end
  end
end
