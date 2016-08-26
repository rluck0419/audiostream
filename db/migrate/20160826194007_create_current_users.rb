class CreateCurrentUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :current_users do |t|
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
