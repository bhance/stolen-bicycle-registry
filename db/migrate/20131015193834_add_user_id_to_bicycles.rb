class AddUserIdToBicycles < ActiveRecord::Migration
  def change
    add_column :bicycles, :user_id, :integer
  end
end
