class AddDefaultValuesToStitches < ActiveRecord::Migration
  def change
    change_column_default(:stitches, :name, '')
    change_column_default(:stitches, :description, '')
    change_column_default(:stitches, :notes, '')
    change_column_default(:stitches, :file_url, '')
    change_column_default(:stitches, :rejected, false)
  end
end
