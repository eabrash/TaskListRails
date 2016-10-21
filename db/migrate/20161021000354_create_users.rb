class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :uid, null: false
      t.string :provider, null: false

      t.timestamps null: false
    end
  end
end
