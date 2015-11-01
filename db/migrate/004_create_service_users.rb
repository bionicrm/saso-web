class CreateServiceUsers < ActiveRecord::Migration
  def change
    create_table :service_users do |t|
      t.references :user,
                   index: true,
                   foreign_key: true,
                   null: false

      t.references :service,
                   index: true,
                   foreign_key: true,
                   null: false

      t.references :auth_token,
                   index: true,
                   foreign_key: true,
                   null: false

      t.text :service_unique_id,
             null: false

      t.timestamps null: false
    end
  end
end
