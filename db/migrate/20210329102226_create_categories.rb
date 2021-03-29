class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :logo_link, default: "category/icon/default.svg"
      t.string :photo_link, default: "category/image/default.jpg"
    end
  end
end
