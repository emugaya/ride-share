class CreateRideMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :ride_matches do |t|
      t.belongs_to :ride, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
