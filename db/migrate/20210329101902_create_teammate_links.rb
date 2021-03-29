class CreateTeammateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :teammate_links do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "pending"
      t.references :teammate, null: false, foreign_key: {to_table: :users}
    end
  end
end
