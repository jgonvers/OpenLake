class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
    end
  end
end
