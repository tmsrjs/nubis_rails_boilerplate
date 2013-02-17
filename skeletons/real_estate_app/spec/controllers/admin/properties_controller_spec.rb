require 'spec_helper'

describe Admin::PropertiesController do
  render_views
  
  it 'gets all properties' do
    property = create(:property)
    sign_in create(:admin_user)
    get :index
    assigns(:properties).should == [property]
  end
end
