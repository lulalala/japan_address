class CreateMunicipalities < ActiveRecord::Migration[5.1]
  def change
    create_table :municipalities do |t|
      t.integer :prefecture_id
      t.integer :gun_id
      t.string :name

      t.timestamps
    end
  end
end
