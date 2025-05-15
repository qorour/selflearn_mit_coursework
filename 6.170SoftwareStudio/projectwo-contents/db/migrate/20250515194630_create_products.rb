class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.timestamps
    end
  end
end
