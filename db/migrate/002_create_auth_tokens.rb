class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.text :access,
             null: false

      t.text :refresh,
             null: true

      t.timestamp :expires_at,
                  null: true

      t.timestamps null: false
    end
  end
end
