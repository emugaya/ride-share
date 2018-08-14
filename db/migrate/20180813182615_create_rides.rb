class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.datetime :time
      t.string :ride_type
      t.string :from_location
      t.string :destination
      t.string :info
      t.integer :seats
      t.string :status

      t.timestamps
    end
  end
end
