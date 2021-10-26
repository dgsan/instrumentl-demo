class CreateTaxEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :tax_entities do |t|
      t.string :ein, index: { unique: true }
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :post_code
      t.integer :flags, null: false, default: 0

      t.timestamps
    end
  end
end
