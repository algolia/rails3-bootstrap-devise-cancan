class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.boolean :premium, null: false, default: false
      t.boolean :released, null: false, default: false
      t.timestamps
    end
  end
end
