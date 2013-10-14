class ChangePostalCodeType < ActiveRecord::Migration
  def self.up
    change_table :bicycles do |t|
      t.change :postal_code, :string
    end
  end
 
  def self.down
    change_table :bicycles do |t|
      t.change :postal_code, :integer
    end
  end
end
