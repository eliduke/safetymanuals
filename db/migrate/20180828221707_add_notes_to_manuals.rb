class AddNotesToManuals < ActiveRecord::Migration[5.1]
  def change
    add_column :manuals, :notes, :text
  end
end
