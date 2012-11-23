run "rm public/index.html"
# Some gems we always use
gem_group :development, :test do
  gem "rspec-rails", ">= 2.11.0"
  gem "factory_girl_rails", ">= 4.1.0"
  gem "quiet_assets", ">= 1.0.1"
  gem 'debugger'
end

gem_group :development do
  gem "haml-rails", ">= 0.3.5"
  gem "hpricot", ">= 0.8.6"
  gem "ruby_parser", ">= 2.3.1"
end

gem_group :test do
  gem "email_spec", ">= 1.2.1"
  gem "capybara"
  gem 'capybara-webkit', '0.12.0'
end

gem 'settingslogic'
gem 'unicorn'
gem 'capistrano'
gem "bootstrap-sass", ">= 2.1.0.0"
gem 'haml'
gem 'jquery-rails'
gem 'email_validator'
gem 'exception_notification', git: 'git://github.com/smartinez87/exception_notification.git'
gem 'nubis_rails_boilerplate', git: 'git://github.com/nubis/nubis_rails_boilerplate.git'
gem "simple_form"
gem 'activeadmin'

run "bundle install"

rake "db:create"

run 'rails generate rspec:install'

file 'Capfile', <<-CODE
load 'deploy'
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each do |plugin|
  load(plugin)
end
load 'config/deploy'
CODE

file 'config/deploy.rb', <<-CODE
require "bundler/capistrano"
require "nubis_rails_boilerplate"
NubisRailsBoilerplate::Capistrano.new(self, __FILE__, "#{app_name}")
CODE

file 'config/deploy.yml', <<-CODE
mysql_database:
mysql_username:
mysql_host:
mysql_password:
server_url:
aws_access_key_id:
aws_secret_access_key:
s3_bucket_name:
CODE

file 'app/models/settings.rb', <<-CODE
class Settings < Settingslogic
  source "\#{Rails.root}/config/deploy.yml"
end
CODE

run 'rm spec/spec_helper.rb'
file 'spec/spec_helper.rb', <<-CODE
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'email_spec'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'capybara-webkit'
require 'capybara/rspec'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, :type => :controller

  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
CODE

run 'rails generate active_admin:install'
run 'rails generate active_admin:resource admin_user'

file 'spec/controllers/admin/admin_users_controller_spec.rb', <<-CODE
require 'spec_helper'

describe Admin::AdminUsersController do
render_views

it "gets the list of available pre_signups" do
  sign_in create(:admin_user)
  get :index
  assigns(:admin_users).should == AdminUser.all
end
end
CODE

run 'rm app/admin/admin_users.rb'
file 'app/admin/admin_users.rb', <<-CODE
ActiveAdmin.register AdminUser do
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
  
  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
CODE

run 'rm spec/factories/admin_users.rb'
file 'spec/factories/admin_users.rb', <<-CODE
FactoryGirl.define do
  factory :admin_user do
    email 'admin@example.com'
    password 'password'
  end
end
CODE

rake 'db:migrate'
rake 'db:test:prepare'

git :init
git :add => "."
git :commit => %Q{ -m 'Initial commit' }
git remote: "add origin git@github.com:nubis/#{app_name}.git"

