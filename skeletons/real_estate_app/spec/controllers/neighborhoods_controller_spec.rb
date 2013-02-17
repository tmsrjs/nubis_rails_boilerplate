require 'spec_helper'

describe NeighborhoodsController do
  render_views 

  it 'shows all neighborhoods on index' do
    neighborhood = create :neighborhood
    get :index
    response.should be_ok
    assigns(:neighborhoods).should == [neighborhood]
  end
  
  it 'shows a single neighborhood' do
    neighborhood = create :neighborhood
    get :show, id: neighborhood.id
    response.should be_ok
    assigns(:neighborhood).should == neighborhood
  end
end
