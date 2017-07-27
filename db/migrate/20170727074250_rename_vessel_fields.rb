class RenameVesselFields < ActiveRecord::Migration[5.1]
  def change
    rename_column :manuals, :vessel_make, :make
    rename_column :manuals, :vessel_model, :model
  end
end
