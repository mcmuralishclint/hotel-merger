# frozen_string_literal: true

class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels, id: :string do |t|
      t.integer :destination_id
      t.string :name
      t.text :description
      t.timestamps
    end

    add_deleted_at_column
    add_indexes
  end

  private

  def add_deleted_at_column
    add_column :hotels, :deleted_at, :datetime
  end

  def add_indexes
    add_index :hotels, :deleted_at
    add_index :hotels, :destination_id
  end
end
