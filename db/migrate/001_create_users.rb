class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name,
             null: false

      t.text :email,
             null: true,
             uniqueness: true

      t.timestamps null: false
    end
  end
end
