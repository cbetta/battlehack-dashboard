class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.text :text

      t.timestamps
    end
  end
end
