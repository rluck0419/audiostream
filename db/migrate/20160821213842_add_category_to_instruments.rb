class AddCategoryToInstruments < ActiveRecord::Migration[5.0]
  def change
    add_column :instruments, :category, :string
  end
end
