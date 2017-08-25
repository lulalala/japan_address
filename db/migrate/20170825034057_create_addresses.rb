class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :full_address
      t.string :prefecture
      t.string :gun
      t.string :municipality
      t.string :other

      t.timestamps
    end
  end
end
