class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false, primary_key: :id do |t|
      t.string :id
      t.string :first_name
      t.string :email
      t.string :image_url
    end

    execute %Q{ ALTER TABLE "users" ADD PRIMARY KEY ("id"); }
  end
end
