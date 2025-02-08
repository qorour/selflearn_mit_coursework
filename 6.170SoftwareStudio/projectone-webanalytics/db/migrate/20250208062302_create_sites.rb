class CreateSites < ActiveRecord::Migration[8.0]
  def change
    create_table :sites do |t|
      t.integer :identifier
      t.integer :visit_count

      t.timestamps
    end
  end
end
