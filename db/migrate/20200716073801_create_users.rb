class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.integer :age
      t.boolean :is_admin
      t.integer :gender

      t.timestamps
    end
  end
end
