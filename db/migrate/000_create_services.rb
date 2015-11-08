class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name,
               null: false,
               uniqueness: true

      t.string :proper_name,
               null: false,
               uniqueness: true

      t.string :logo_file,
               null: false,
               uniqueness: true
    end
  end
end
