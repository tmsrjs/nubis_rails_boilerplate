#encoding: utf-8
FactoryGirl.define do
  factory :neighborhood do
    name 'House in the hill'
    url_name 'house_in_the_hill'
    description "This is a house in the hill"
    amenities "gas: has it\ngos: has it too"
    images_attributes {
      {'0' =>
        {'file' =>
           Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.jpg'), 'image/jpg')
        }
      }
    }
  end
end
