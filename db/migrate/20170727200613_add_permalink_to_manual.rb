class AddPermalinkToManual < ActiveRecord::Migration[5.1]
  def self.up
    add_column :manuals, :permalink, :string
    add_index :manuals, :permalink
  end
  def self.down
    remove_column :manuals, :permalink
  end
end
