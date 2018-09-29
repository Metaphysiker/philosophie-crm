class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.integer :philosophie_id
      t.string :login
      t.integer :creator_id

      t.timestamps
    end
  end
end
