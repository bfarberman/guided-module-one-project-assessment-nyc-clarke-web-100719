class CreateVenues < ActiveRecord::Migration[5.2]
  def change
      create_table :venues do |t|
          t.string :name
          t.string :address
          t.string :neighborhood
          t.string :size
          t.integer :city_id
      end
  end 
end