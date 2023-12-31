# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :hotel, null: false, foreign_key: true, type: :string
      t.string :image_type
      t.string :link
      t.string :description

      t.timestamps
    end
    add_index :images, %i[hotel_id image_type link], unique: true
  end
end
