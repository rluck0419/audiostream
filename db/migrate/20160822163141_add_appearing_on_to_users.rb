class AddAppearingOnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :appearing_on, :string
  end
end
