class AddRevisionToManuals < ActiveRecord::Migration[5.1]
  def change
    add_column :manuals, :revision, :string
  end
end
