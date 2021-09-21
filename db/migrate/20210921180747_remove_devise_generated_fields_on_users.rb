class RemoveDeviseGeneratedFieldsOnUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :name, :string
    remove_column :users, :nickname, :string
    remove_column :users, :image, :string
  end
end
