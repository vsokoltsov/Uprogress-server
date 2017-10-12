# frozen_string_literal: true

class AddSlugToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :slug, :string, index: true
  end
end
