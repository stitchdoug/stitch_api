class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.integer :stitch_id

      t.timestamps
    end

    add_index :images, [:stitch_id, :created_at]
  end
end
