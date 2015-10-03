class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :access,
               null: false

      t.string :refresh,
               null: true

      t.boolean :expires,
                null: false

      t.timestamp :expires_at,
                  null: true

      t.timestamps null: false
    end
  end
end
