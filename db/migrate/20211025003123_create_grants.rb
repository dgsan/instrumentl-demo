class CreateGrants < ActiveRecord::Migration[6.1]
  def change
    create_table :grants do |t|
      t.string :from_ein, index: true
      t.string :to_ein, index: true
      t.decimal :amount, index: true
      t.integer :year, index: true
      t.timestamps
    end
    add_foreign_key :grants, :tax_entities, column: :from_ein, primary_key: :ein
    add_foreign_key :grants, :tax_entities, column: :to_ein, primary_key: :ein
  end
end
