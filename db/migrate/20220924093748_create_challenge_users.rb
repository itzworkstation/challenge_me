class CreateChallengeUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_users do |t|
      t.references :challenge
      t.references :shared_by, null: false, references: :users, foreign_key: {to_table: :users}
      t.references :accepted_by, null: false, references: :users, foreign_key: {to_table: :users}
      t.integer :state, default: 0
      t.timestamps
    end
  end
end
