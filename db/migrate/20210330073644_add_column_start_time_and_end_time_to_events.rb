class AddColumnStartTimeAndEndTimeToEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :datetime
    add_column :events, :start_time, :datetime
    add_column :events, :end_time, :datetime
  end
end
