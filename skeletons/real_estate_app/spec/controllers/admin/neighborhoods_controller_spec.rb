require 'spec_helper'

describe Admin::NeighborhoodsController do
  render_views

  it 'gets all neighborhoods' do
    neighborhood = create(:neighborhood)
    sign_in create(:admin_user)
    get :index
    assigns(:neighborhoods).should == [neighborhood]
  end
end
