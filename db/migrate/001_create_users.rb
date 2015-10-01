class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :provider,
                   index: true,
                   foreign_key: true,
                   null: false

      t.string :name,
               limit: 64,
               null: false

      t.string :email,
               limit: 254,
               null: true,
               uniqueness: true

      t.timestamps null: false
    end
  end
end
