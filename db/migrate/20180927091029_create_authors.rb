class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :content
      t.string :avatar

      t.timestamps
    end
  end
end
