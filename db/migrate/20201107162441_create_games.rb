class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :rows
      t.integer :cols
      t.integer :mines

      t.timestamps
    end
  end
end
