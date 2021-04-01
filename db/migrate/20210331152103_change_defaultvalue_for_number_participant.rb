class ChangeDefaultvalueForNumberParticipant < ActiveRecord::Migration[6.0]
  def change
    change_column_default :events, :participants_maximum, from: false, to: nil
  end
end
