class CreateWishKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :wish_keywords do |t|
      t.references :wish, null: false, foreign_key: true
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end
  end
end
