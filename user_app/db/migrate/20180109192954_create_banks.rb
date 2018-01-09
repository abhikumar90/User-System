class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :branch
      t.integer :amount
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
