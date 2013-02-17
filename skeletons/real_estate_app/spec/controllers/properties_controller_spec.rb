require 'spec_helper'

describe PropertiesController do
  render_views 

  it 'shows all properties on index' do
    property = create :property
    get :index
    response.should be_ok
    assigns(:properties).should == [property]
  end
  
  it 'shows a single property' do
    property = create :property
    get :show, id: property.id
    response.should be_ok
    assigns(:property).should == property
  end
end
