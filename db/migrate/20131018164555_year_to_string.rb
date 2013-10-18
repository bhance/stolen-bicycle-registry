class YearToString < ActiveRecord::Migration
  def change
    remove_column :bicycles, :year
    add_column :bicycles, :year, :string
    add_column :bicycles, :approved, :boolean, default: false
    add_column :bicycles, :hidden, :boolean, default: false
    add_column :bicycles, :recovered, :boolean, default: false
  end
end
