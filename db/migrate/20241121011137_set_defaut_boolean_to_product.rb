class SetDefautBooleanToProduct < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :active, :boolean, default: true
  end
end
