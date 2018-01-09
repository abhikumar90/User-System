class CreatePinProperties < ActiveRecord::Migration
  def change
    create_table :pin_properties do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.integer :user_id

      t.timestamps 
    end
  end
end
