class RemoveStolenFrom < ActiveRecord::Migration
  def change
    remove_column :bicycles, :theft_origin
  end
end