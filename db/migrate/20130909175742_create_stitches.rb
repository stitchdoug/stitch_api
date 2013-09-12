class CreateStitches < ActiveRecord::Migration
  def change
    create_table :stitches do |t|
      t.string :name, default: ''
      t.string :description, default: ''
      t.integer :user_id
      t.text :notes, default: ''
      t.boolean :rejected, default: false
      t.string :file_url, default: ''

      t.timestamps
    end
    add_index :stitches, [:user_id, :created_at]
  end
end
