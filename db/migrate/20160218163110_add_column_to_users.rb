class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address1, :string
  end
end
