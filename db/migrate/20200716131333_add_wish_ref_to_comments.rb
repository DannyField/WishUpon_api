class AddWishRefToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :wish, null: false, foreign_key: true
  end
end
