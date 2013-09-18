class DropFileUrlFromStitches < ActiveRecord::Migration
  def change
    remove_column :stitches, :file_url
  end
end
