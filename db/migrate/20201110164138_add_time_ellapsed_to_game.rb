class AddTimeEllapsedToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :time_ellapsed, :integer, default: 0
  end
end
