class RemoveColumnToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :address1, :string
  end
end
