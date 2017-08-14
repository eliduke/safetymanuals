class AddModeToManuals < ActiveRecord::Migration[5.1]
  def change
    add_column :manuals, :mode, :string
  end
end
