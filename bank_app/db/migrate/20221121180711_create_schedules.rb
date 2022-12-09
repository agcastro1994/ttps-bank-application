class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.references :office, null: false, foreign_key: true
      t.text :days, array: true, default: [].to_yaml
      t.timestamps
    end
  end
end
