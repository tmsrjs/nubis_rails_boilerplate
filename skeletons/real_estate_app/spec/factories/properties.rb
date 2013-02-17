#encoding: utf-8
FactoryGirl.define do
  factory :property do
    name 'House in the hill'
    url_name 'house_in_the_hill'
    description "This is a house in the hill"
    neighborhood
    latitude 10.00000
    longitude 10.0000
    address 'Evergreen rd 123'
    public_address 'Around evergreen avenue'
    covered_square_meters 10
    uncovered_square_meters 10
    rooms 4
    bathrooms 4
    amenities "gas: has it\ngos: has it too"
    keywords "gas, house, hill"
    for_rent true
    for_sale false
    images_attributes {
      {'0' =>
        {'file' =>
           Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.jpg'), 'image/jpg')
        }
      }
    }
  end
end
