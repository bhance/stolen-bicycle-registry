class RenameStateAndZipColumnsInUsers < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :state, :region
    t.rename :zip, :postal_code
  end
end
