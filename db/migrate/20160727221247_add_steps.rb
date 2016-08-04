class AddSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.belongs_to :direction, index: true, null: false
      t.string :title, index: true, null: false
      t.text :description, null: false
      t.boolean :is_done, index: true, default: false
      t.timestamps
    end
  end
end
