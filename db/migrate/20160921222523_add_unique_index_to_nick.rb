# frozen_string_literal: true
class AddUniqueIndexToNick < ActiveRecord::Migration
  def up
    remove_index :users, :nick if index_exists?(:users, :nick)
    add_index :users, :nick, unique: true
  end

  def down
    remove_index :users, :nick
  end
end
