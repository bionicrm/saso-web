class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :provider, index: true, foreign_key: true
      t.string :name, limit: 64
      t.string :email, limit: 254, null: true

      t.timestamps null: false
    end
  end
end
