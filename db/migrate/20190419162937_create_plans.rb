class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :location
      t.integer :party_number
      t.string :shelter_type
    end
  end
end
