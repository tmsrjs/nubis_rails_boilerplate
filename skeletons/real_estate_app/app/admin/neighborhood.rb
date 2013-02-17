ActiveAdmin.register Neighborhood do
  index do
    column :name
    default_actions
  end
  
  show do |product|
    attributes_table_with_images do
      row :name
      row :url_name
      row :description
      row :amenities
    end
  end
  
  form_with_images do |f|
    f.input :name
    f.input :url_name
    f.input :description
    f.input :amenities
  end
end                                   
