class CreateUserReverbs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_reverbs do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :reverb, foreign_key: true

      t.timestamps
    end
  end
end
