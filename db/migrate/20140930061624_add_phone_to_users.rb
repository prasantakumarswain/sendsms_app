class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :name, :string
    add_column :users, :verified, :boolean,:default => false
  end
end
