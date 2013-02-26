class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.date :bought_date

      t.timestamps
    end
  end
end
