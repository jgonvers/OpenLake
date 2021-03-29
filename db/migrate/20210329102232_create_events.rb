class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :creator, null: false, foreign_key: {to_table: :users}
      t.references :category, null: false, foreign_key: true
      t.datetime :datetime
      t.string :status, default: "pending"
      t.string :content
      t.integer :participants_maximum, default: 2
    end
  end
end
