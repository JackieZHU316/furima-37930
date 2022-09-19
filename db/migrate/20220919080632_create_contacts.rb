class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :post_code,           null: false
      t.integer :region_id,          null: false
      t.string :city,                null: false
      t.string :house_number,        null: false
      t.string :building,            null: false
      t.string :phone_number,        null: false
      t.references :purchase,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
