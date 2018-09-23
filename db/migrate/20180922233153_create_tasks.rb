class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :description
      t.datetime :deadline
      t.integer :priority
      t.integer :assigned_to_user_id
      t.integer :creator_id
      t.references :taskable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
