class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :description
      t.references :owner, null: false, references: :users, foreign_key: {to_table: :users}
      t.datetime :start_date
      t.datetime :end_date
      t.integer :state, default: 0
      t.integer :challenge_type, default: 0
      t.timestamps
    end
  end
end
