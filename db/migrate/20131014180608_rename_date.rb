class RenameDate < ActiveRecord::Migration
  def change
    rename_column :bicycles, :date_stolen, :date
  end
end
