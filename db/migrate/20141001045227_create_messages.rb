class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :phone
      t.text :sms
      t.integer :user_id
      t.timestamps
    end
  end
end
