class CreateManuals < ActiveRecord::Migration[5.1]
  def change
    create_table :manuals do |t|
      t.string :company
      t.string :vessel_make
      t.string :vessel_model

      t.timestamps
    end
  end
end
