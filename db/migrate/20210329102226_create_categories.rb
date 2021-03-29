class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :logo_link, default: "category/default.svg"
    end
  end
end
