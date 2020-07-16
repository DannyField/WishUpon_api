class CreateWishes < ActiveRecord::Migration[6.0]
  def change
    create_table :wishes do |t|
      t.string :title
      t.text :description
      t.boolean :is_secret
      t.boolean :is_anonymous
      t.boolean :is_completed
      t.boolean :is_matched
      t.integer :like
      t.datetime :expiry_time

      t.timestamps
    end
  end
end
