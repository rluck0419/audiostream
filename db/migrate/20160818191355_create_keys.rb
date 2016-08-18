class CreateKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :keys do |t|
      t.string :name
      t.integer :transposition, limit: 2

      t.timestamps
    end
  end
end
