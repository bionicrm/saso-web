class CreateLiveTokens < ActiveRecord::Migration
  def change
    create_table :live_tokens do |t|
      t.references :user,
                   index: true,
                   foreign_key: true,
                   null: false

      t.string :token,
               limit: 64,
               null: false,
               uniqueness: true

      t.binary :ip,
               limit: 16,
               null: false

      t.timestamp :expires_at,
                  null: false

      t.timestamps null: false
    end
  end
end
