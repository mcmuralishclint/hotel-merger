class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels, id: :string do |t|
      t.integer :destination_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
