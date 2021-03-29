class ChangeDefaultValueTeammateLinkStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :teammate_links, :status, :string, default: 'pending'
  end
end
