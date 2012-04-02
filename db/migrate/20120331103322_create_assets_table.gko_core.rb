# This migration comes from gko_core (originally 20120330222222)
class CreateAssetsTable < ActiveRecord::Migration
  def up
    unless table_exists?(:assets)
      create_table :assets do |t|
        t.references :account
        t.references :site
        t.integer :asset_assignments_count, :default => 0
        t.string :type
        t.string :asset_mime_type
        t.string :asset_name
        t.integer :asset_size
        t.integer :asset_width
        t.integer :asset_height
        t.string :asset_uid
        t.string :asset_ext
        t.timestamps
      end 

      create_table :asset_assignments do |t|
        t.integer :position, :null => false, :default => 1
        t.references :asset, :null => false
        t.integer :attachable_id, :null => false
        t.string :attachable_type, :null => false, :limit => 40
        t.timestamps
      end

      add_index :asset_assignments, [:attachable_id, :attachable_type]  
    end
  end

  def down
    drop_table :assets
    drop_table :asset_assignments
  end
end
