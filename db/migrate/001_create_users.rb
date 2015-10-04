class CreateUsers < ActiveRecord::Migration
  def change
    enable_extension 'citext' unless extension_enabled? 'citext'

    create_table :users do |t|
      t.citext :name,
               null: false

      t.citext :email,
               null: true,
               uniqueness: true

      t.timestamps null: false
    end
  end
end
