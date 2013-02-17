ActiveAdmin.register Property do
  index do
    column :name
    column :address
    column :for_rent
    column :for_sale
    default_actions
  end
  
  show do |product|
    attributes_table_with_images do
      row :name
      row :url_name
      row :description
      row :neighborhood
      row :latitude
      row :longitude
      row :address
      row :public_address
      row :covered_square_meters
      row :uncovered_square_meters
      row :rooms
      row :bathrooms
      row :amenities
      row :keywords
      row :for_rent
      row :for_sale
    end
  end
  
  form_with_images do |f|
    f.input :name
    f.input :url_name
    f.input :description
    f.input :neighborhood
    f.input :latitude
    f.input :longitude
    f.input :address
    f.input :public_address
    f.input :covered_square_meters
    f.input :uncovered_square_meters
    f.input :rooms
    f.input :bathrooms
    f.input :amenities
    f.input :keywords
    f.input :for_rent
    f.input :for_sale
  end
end                                   
