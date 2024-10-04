class CreateResidences < ActiveRecord::Migration[7.0]
  def change
    create_table :residences do |t|
      t.string :postal_code, null: false
      t.string :city, null: false
      t.string :adress, null: false
      t.string :building_name, null: false
      t.string :phone_num , null: false
      t.integer :prefecture_id, null: false
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
