class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rol, :integer
  end
end
