class RenameColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :bookings, :products_id, :product_id
    rename_column :products, :brands_id, :brand_id
    rename_column :products, :categories_id, :category_id
  end
end
