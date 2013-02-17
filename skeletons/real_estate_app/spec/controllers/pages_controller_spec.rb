require 'spec_helper'

describe PagesController do
  render_views

  it 'has a home page' do
    get :home
    response.should be_ok
  end
  
  it 'has an about us page' do
    get :about_us
    response.should be_ok
  end
  
  it 'has a terms of service page' do
    get :terms_of_service
    response.should be_ok
  end
  
  it 'has a privacy policy page' do
    get :privacy_policy
    response.should be_ok
  end
  
  it 'has a contact us page' do
    get :contact_us
    response.should be_ok
  end
end

