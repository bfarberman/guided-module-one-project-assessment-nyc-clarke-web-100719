class CreateBands < ActiveRecord::Migration[5.2]
  def change
      create_table :bands do |t|
          t.string :name
          t.string :genre
          t.string :popularity
      end
  end 
end