class CreateShows < ActiveRecord::Migration[5.2]
  def change
      create_table :shows do |t|
          t.datetime :start_time
          t.datetime :end_time
          t.integer :venue_id
          t.integer :band_id
      end
  end 
end
