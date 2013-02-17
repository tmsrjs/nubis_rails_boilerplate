require 'spec_helper'

describe Admin::AdminUsersController do
  render_views

  it "gets the list of available pre_signups" do
    sign_in create(:admin_user)
    get :index
    assigns(:admin_users).should == AdminUser.all
  end
end
