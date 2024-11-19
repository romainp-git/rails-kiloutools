class RemovePhotoUrlToUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :photo_url
    remove_column :products, :photo_url
  end
end
