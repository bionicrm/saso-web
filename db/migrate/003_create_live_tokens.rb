class CreateLiveTokens < ActiveRecord::Migration
  def change
    create_table :live_tokens do |t|
      t.references :user, index: true, foreign_key: true
      t.string :token, limit: 16
      t.binary :ip, limit: 16
      t.boolean :is_active
      t.boolean :is_used

      t.timestamps null: false
    end
  end
end
