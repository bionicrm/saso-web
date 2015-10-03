class CreateLiveTokens < ActiveRecord::Migration
  def change
    create_table :live_tokens do |t|
      t.references :user,
                   index: true,
                   foreign_key: true,
                   null: false

      t.string :token,
               limit: 32,
               null: false,
               uniqueness: true

      t.binary :ip,
               limit: 16,
               null: false

      t.boolean :is_active,
                null: false,
                default: false

      t.boolean :is_used,
                null: false,
                default: false

      t.timestamps null: false
    end
  end
end
