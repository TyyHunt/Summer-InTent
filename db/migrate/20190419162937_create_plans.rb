class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :location
      t.date :dates 
      t.integer :party_number
      t.string :shelter_type
    end
  end
end
