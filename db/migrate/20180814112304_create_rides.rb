class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.datetime :time
      t.string :ride_type
      t.string :from_location
      t.string :destination
      t.integer :seats
      t.belongs_to :user, index: true, type: :string

      t.timestamps
    end
  end
end
