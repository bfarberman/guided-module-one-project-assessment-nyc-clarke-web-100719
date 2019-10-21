class CreateShows < ActiveRecord::Migration[5.2]
  def change
      create_table :shows do |t|
          t.string :date
          t.string :start_time
          t.string :end_time
          t.integer :venue_id
          t.integer :band_id
      end
  end 
end
