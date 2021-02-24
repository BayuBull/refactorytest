class Bokings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
        t.references :user, foreign_key: true
        t.references :room, foreign_key: true
        t.integer :total_person
        t.datetime :boking_time
        t.string :noted
        t.datetime :check_in_time
        t.datetime :check_out_time
        t.datetime :deleted_at
        
        t.timestamps
    end
  end
end
