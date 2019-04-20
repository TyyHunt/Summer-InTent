class AddColumnToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :user_id, :Integer
  end
end
