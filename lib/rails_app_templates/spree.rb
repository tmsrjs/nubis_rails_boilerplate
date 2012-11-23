run "rm public/index.html"
git :init
git :add => "."
git :commit => %Q{ -m 'Initial commit' }

# Some gems we always use
gem_group :development, :test do
  gem "rspec-rails", ">= 2.11.0"
  gem "capybara"
  gem 'debugger'
end

gem 'settingslogic'
gem 'sass-rails', '~> 3.2.3'
gem 'unicorn'
gem 'capistrano'
gem 'spree', '1.2.0'
gem 'spree_gateway', :git => 'git://github.com/spree/spree_gateway.git', :branch => "1-2-stable"
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise'
gem 'spree_admin_dark', git: 'git://github.com/nubis/spree_admin_dark'
gem 'haml'
gem 'exception_notification', git: 'git://github.com/smartinez87/exception_notification.git'
gem 'nubis_rails_boilerplate', git: 'git://github.com/nubis/nubis_rails_boilerplate.git'

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

initializer 'spree_s3_images.rb', <<-CODE
if Rails.env.production?
  Spree::Image.class_eval do
    definition = self.attachment_definitions[:attachment]
    definition[:styles] = {
      :mini => '48x48>',
      :small => '55x80>',
      :product => '160x232>',
      :large => '320x464>'
    }
    definition.delete :url
    definition[:path] = definition[:path].gsub(':rails_root/public/', '')
    definition[:storage] = 's3'
    definition[:bucket] = Settings.s3_bucket_name
    definition[:s3_credentials] = {
      access_key_id: Settings.aws_access_key_id,
      secret_access_key: Settings.aws_secret_access_key
    }
  end
end
CODE

git :init
git remote: "add origin git@github.com:nubis/#{app_name}.git"
