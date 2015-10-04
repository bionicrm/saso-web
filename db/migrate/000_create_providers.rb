class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name,
               null: false,
               uniqueness: true
    end
  end
end
