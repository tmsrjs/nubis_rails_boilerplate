class InitialTables < ActiveRecord::Migration
  create_table :images, force: true do |t|
    t.integer :viewable_id
    t.string :viewable_type, limit: 50
    t.attachment :file
    t.integer :position
    t.timestamps
  end

  add_index :images, [:viewable_id], name: :index_images_on_viewable_id
  add_index :images, [:viewable_type], name: :index_images_on_viewable_type
  
  create_table :properties, force: true do |t|
    t.string :name
    t.string :url_name
    t.text :description
    t.references :neighborhood
    t.float :latitude
    t.float :longitude
    t.string :address
    t.string :public_address
    t.integer :covered_square_meters
    t.integer :uncovered_square_meters
    t.integer :rooms
    t.integer :bathrooms
    t.text :amenities
    t.string :keywords
    t.boolean :for_rent
    t.boolean :for_sale
    t.timestamps
  end

  add_index :properties, [:neighborhood_id], name: :index_images_on_neighborhood_id
  
  create_table :neighborhoods, force: true do |t|
    t.string :name
    t.string :url_name
    t.text :description
    t.text :amenities
    t.timestamps
  end
end
