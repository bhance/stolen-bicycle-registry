class AddCountryToBicycles < ActiveRecord::Migration
  def change
    add_column :bicycles, :country, :string
  end
end
