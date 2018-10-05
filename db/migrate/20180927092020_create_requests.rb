class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.datetime :from_day, default: Time.now
      t.datetime :to_day, default: Time.now+7.days
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
