class AddDeletedAtToBicycles < ActiveRecord::Migration
  def change
    add_column :bicycles, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
  end
end
