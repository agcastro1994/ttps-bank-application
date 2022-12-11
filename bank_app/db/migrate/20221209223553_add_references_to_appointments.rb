class AddReferencesToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :offices, foreign_key: true, null: false
    add_reference :appointments, :requester, foreign_key: { to_table: :users }, null: false
    add_reference :appointments, :operator, foreign_key: { to_table: :users }, default: nil  
  end
end
