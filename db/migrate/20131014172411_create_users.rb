class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.boolean :first_name_public
      t.string :last_name
      t.boolean :last_name_public
      t.string :email
      t.boolean :email_public
      t.string :country
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone1
      t.string :phone2

      t.timestamps
    end
  end
end
