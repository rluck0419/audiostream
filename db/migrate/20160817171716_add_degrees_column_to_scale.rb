class AddDegreesColumnToScale < ActiveRecord::Migration[5.0]
  def change
    add_column :scales, :degrees, :smallint, array: true, default: []
  end
end
