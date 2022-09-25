class CreateChallengeInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_invitations do |t|
      t.references :challenge
      t.references :invited_by, null: false, references: :users, foreign_key: {to_table: :users}
      t.references :invited_to, null: true, references: :users, foreign_key: {to_table: :users}
      t.boolean :invitation_accepted, default: false
      t.timestamp :invitation_accepted_at
      t.string :invitation_token
      t.timestamps
    end
  end
end
