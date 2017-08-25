class CreateSubMunicipalities < ActiveRecord::Migration[5.1]
  def change
    create_table :sub_municipalities do |t|
      t.integer :municipality_id
      t.string :name

      t.timestamps
    end
  end
end
