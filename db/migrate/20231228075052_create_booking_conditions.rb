class CreateBookingConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_conditions do |t|
      t.references :hotel, null: false, foreign_key: true, type: :string
      t.text :condition

      t.timestamps
    end
    add_index :booking_conditions, [:hotel_id, :condition], unique: true
  end
end
