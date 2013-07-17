class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.string :status, default: "cleared"
      t.datetime :started_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
