# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :hotel, null: false, foreign_key: true, type: :string
      t.float :lat
      t.float :lng
      t.string :address
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
