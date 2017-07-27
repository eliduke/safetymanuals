class ChangeCompanyToCarrier < ActiveRecord::Migration[5.1]
  def change
    rename_column :manuals, :company, :carrier
  end
end
