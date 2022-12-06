class CreateOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :offices do |t|
      t.string :name, unique: true
      t.text :address
      t.string :phone

      t.timestamps
    end
  end
end
