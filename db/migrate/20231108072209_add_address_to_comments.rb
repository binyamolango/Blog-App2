class AddAddressToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :address, :string
    add_index :comments, :address
  end
end
