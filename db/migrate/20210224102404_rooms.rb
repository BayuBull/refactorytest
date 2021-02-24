class Rooms < ActiveRecord::Migration[5.2]
    def change
      create_table :rooms do |t|
        t.string :room_name
        t.string :room_capacity
        t.string :photo
        t.date :deleted_at
        
        t.timestamps
    end
  end
end
