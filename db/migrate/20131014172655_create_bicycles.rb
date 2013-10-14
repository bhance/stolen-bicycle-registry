class CreateBicycles < ActiveRecord::Migration
  def change
    create_table :bicycles do |t|
      t.date :date_stolen
      t.string :city
      t.string :state
      t.integer :zip
      t.string :serial
      t.boolean :verified_ownership
      t.string :police_report
      t.string :theft_origin
      t.text :description
      t.integer :reward
      t.integer :year
      t.string :brand
      t.string :model
      t.string :color
      t.integer :size
      t.string :size_type

      t.timestamps
    end
  end
end
