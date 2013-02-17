require 'spec_helper' 

describe Image do
  it 'has an attachment' do
    Image.new(
      file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image.jpg'), 'image/jpg'),
      position: 1
    )
  end
end
