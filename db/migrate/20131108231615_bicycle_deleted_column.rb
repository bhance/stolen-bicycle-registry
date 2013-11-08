class BicycleDeletedColumn < ActiveRecord::Migration
  def change
    add_column :bicycles, :deleted, :boolean, default: false
  end
end
