class ChangeContentEventFromStringToText < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :content, :text
  end
end
