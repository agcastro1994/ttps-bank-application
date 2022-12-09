class AddOfficeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :offices, foreign_key: true, default: nil
  end
end
