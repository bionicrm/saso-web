class CreateProviderUsers < ActiveRecord::Migration
  def change
    create_table :provider_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :provider, index: true, foreign_key: true
      t.string :provider_unique_id, limit: 64
      t.string :access_token, limit: 255, null: true
      t.string :refresh_token, limit: 255, null: true

      t.timestamps null: false
    end
  end
end
