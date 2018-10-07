class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
