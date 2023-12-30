# frozen_string_literal: true

class CreateAmenities < ActiveRecord::Migration[7.0]
  def change
    create_table :amenities do |t|
      t.references :hotel, null: false, foreign_key: true, type: :string
      t.string :amenity_type
      t.string :name

      t.timestamps
    end
    add_index :amenities, %i[hotel_id amenity_type name], unique: true
  end
end
