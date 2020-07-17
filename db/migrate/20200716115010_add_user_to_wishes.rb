class AddUserRefToWish < ActiveRecord::Migration[6.0]
  def change
    add_reference :wishes, :user, null: false, foreign_key: true
  end
end
