run "rm public/index.html"
git :init
git :add => "."
git :commit => %Q{ -m 'Initial commit' }

# Some gems we always use
gem_group :development, :test do
  gem "rspec-rails", ">= 2.11.0"
  gem "capybara"
end

gem 'sass-rails', '~> 3.2.3'
gem 'unicorn'
gem 'capistrano'
gem 'debugger'
gem 'spree', '1.2.0'
gem 'spree_gateway', :git => 'git://github.com/spree/spree_gateway.git', :branch => "1-2-stable"
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise'
gem 'spree_admin_dark', git: 'git://github.com/nubis/spree_admin_dark'
gem 'haml'
gem 'exception_notification', git: 'git://github.com/smartinez87/exception_notification.git'

run "bundle install"

rake "db:create"

run "rails generate spree:install --user-class=Spree::User --sample=false --auto-accept=true"
run 'rails generate spree_admin_dark:install'

file 'Capfile', <<-CODE
load 'deploy'
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each do |plugin|
  load(plugin)
end
load 'config/deploy'
CODE

file 'config/deploy.rb', <<-CODE
set :mysql_database, "#{app_name}"
set :mysql_username, "#{app_name}"
set :mysql_host, "<enter your mysql host name here>"
server "<enter your server ip here>", :web, :app, :db, primary: true

require "bundler/capistrano"
require "nubis_rails_boilerplate"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mysql"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/nodejs"

set :user, "ubuntu"
set :application, "#{app_name}"
set :deploy_to, "/home/ubuntu/apps/#{app_name}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:nubis/#{app_name}.git"
set :branch, "master"
set :keep_releases, 2

ssh_options[:keys] = File.expand_path('../../permission.pem', __FILE__)
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
CODE

