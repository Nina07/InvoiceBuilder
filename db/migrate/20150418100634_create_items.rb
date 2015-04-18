class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :order, index: true, foreign_key: true
      t.string :product_name
      t.integer :qty
      t.decimal :rate
      t.boolean :received

      t.timestamps null: false
    end
  end
end
