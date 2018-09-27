class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.references :author, foreign_key: true
      t.references :publisher, foreign_key: true
      t.text :content
      t.integer :number_page
      t.integer :year
      t.string :status

      t.timestamps
    end
  end
end
