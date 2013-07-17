class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :text
      t.boolean :visible, default: false

      t.timestamps
    end
  end
end
