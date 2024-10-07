class RenameAdressToAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :residences, :adress, :address
  end
end
