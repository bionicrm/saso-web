class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 64
      t.string :email, limit: 254, null: true

      t.timestamps null: false
    end
  end
end
