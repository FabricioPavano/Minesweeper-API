class AddEndedColumnToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :ended, :boolean, :default => false
  end
end
