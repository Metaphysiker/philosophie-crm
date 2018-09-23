class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :description
      t.integer :creator_id
      t.references :noteable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
