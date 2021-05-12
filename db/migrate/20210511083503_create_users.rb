class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email, null: false
      t.integer :role, default: 0
      t.string :remember_digest
      t.string :activation_digest
      t.string :password_digest
      t.string :reset_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.datetime :reset_sent_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
