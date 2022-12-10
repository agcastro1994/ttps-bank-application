class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.datetime :hour
      t.string :reason
      t.integer :status
      t.text :comment

      t.timestamps      
    end
  end
end
