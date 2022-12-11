class UpdateAppointmentOfficeKeyCascadeDeletion < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :appointments, :offices
    add_foreign_key :appointments, :offices, column: "offices_id", on_delete: :cascade
  end
end
