class AddColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :entity_id, :integer
    add_column :images, :entity_type, :string
  end
end
