# Helps rendering a form which is associated to image models.
require 'activeadmin'

module NubisRailsBoilerplate
  module ActiveAdminHelpers
    def form_with_images(section_title = "Images", &config)
      form html: {id: 'has_many_images', multipart: true} do |f|
        f.inputs("#{f.object.class.to_s} Details"){ config.call(f) }

        f.has_many :images, title: 'images' do |fi|
          fi.inputs "Images" do
            if fi.object.new_record?
              fi.input :file, as: :file
            else
              fi.input :_destroy, :as => :boolean, :label => "Destroy?",
                :hint => fi.template.image_tag(fi.object.file.url(:small)) 
            end
          end
        end

        f.actions
      end
    end

    def attributes_table_with_images(&config)
      attributes_table do
        config.call
        row :images do |item|
          item.images.collect do |image|
            image_tag(image.file.url(:small))
          end.join.html_safe
        end
      end
      active_admin_comments
    end
  end
end

class ActiveAdmin::ResourceDSL
  include NubisRailsBoilerplate::ActiveAdminHelpers
end

class ActiveAdmin::Views::Pages::Show
  include NubisRailsBoilerplate::ActiveAdminHelpers
end
