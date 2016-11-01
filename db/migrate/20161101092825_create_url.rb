class CreateUrl < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.string :original, :null => false
      t.string :key, :null => false, unique: true
      t.integer :redirects, :default => 0
      t.timestamps
    end

    add_index :urls, :key, unique: true
  end
end
