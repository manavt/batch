class RemoveColumnToImages < ActiveRecord::Migration
  def change
    remove_reference :images, :product, index: true, foreign_key: true
  end
end
