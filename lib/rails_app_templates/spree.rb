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

