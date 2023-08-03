class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string     :post_code, null: false
      t.string     :prefecture_id, null: false
      t.string     :municipalities, null: false
      t.string     :address, null: false
      t.string     :building_name
      t.string     :phone_number, null: false
      t.references :purchase, null: false, foreign_key: true
      t.timestamps
    end
  end
end
