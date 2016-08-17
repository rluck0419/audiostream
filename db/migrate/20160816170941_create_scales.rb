class CreateScales < ActiveRecord::Migration[5.0]
  def change
    create_table :scales do |t|
      t.text :name

      t.timestamps
    end
  end
end
