class CreateAmenities < ActiveRecord::Migration[7.0]
  def change
    create_table :amenities do |t|
      t.references :hotel, null: false, foreign_key: true, type: :string
      t.string :amenity_type
      t.string :name

      t.timestamps
    end
  end
end
