require 'spec_helper' 

describe Image do
  it 'validates common factory' do
    expect{ create :property }.not_to raise_exception
  end
end
