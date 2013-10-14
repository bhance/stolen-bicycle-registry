class ModifyZipCode < ActiveRecord::Migration
  def change
    rename_column :bicycles, :state, :region
    rename_column :bicycles, :zip, :postal_code
  end
end
