class CreateUserReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :user_reviews do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :title
      t.text :content
      t.integer :rate

      t.timestamps
    end
  end
end
