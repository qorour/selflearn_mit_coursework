class CreateSites < ActiveRecord::Migration[8.0]
  def change
    create_table :sites do |t|
      t.integer :identifier
      t.integer :visit_count
      t.integer :total_time_spent, default: 0

      t.timestamps
    end
  end
end
