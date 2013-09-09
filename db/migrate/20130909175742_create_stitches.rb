class CreateStitches < ActiveRecord::Migration
  def change
    create_table :stitches do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.text :notes
      t.boolean :rejected
      t.string :file_url

      t.timestamps
    end
    add_index :stitches, [:user_id, :created_at]
  end
end
