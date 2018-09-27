class CreateRequestDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :request_details do |t|
      t.references :request, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
