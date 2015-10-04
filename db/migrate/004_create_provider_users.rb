class CreateProviderUsers < ActiveRecord::Migration
  def change
    create_table :provider_users do |t|
      t.references :user,
                   index: true,
                   foreign_key: true,
                   null: false

      t.references :provider,
                   index: true,
                   foreign_key: true,
                   null: false

      t.references :auth_token,
                   index: true,
                   foreign_key: true,
                   null: false

      t.text :provider_unique_id,
             null: false

      t.timestamps null: false
    end
  end
end
