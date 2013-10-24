class RecoveredDate < ActiveRecord::Migration
  def change
    add_column :bicycles, :recovered_date, :date
  end
end
