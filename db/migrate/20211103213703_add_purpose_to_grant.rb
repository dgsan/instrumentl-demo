class AddPurposeToGrant < ActiveRecord::Migration[6.1]
  def change
    change_table :grants do |t|
      t.string :purpose
    end
  end
end
