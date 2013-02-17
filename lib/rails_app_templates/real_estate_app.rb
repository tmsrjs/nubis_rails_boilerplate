run "bundle install"
rake "db:create"

# replace app_name in config/deploy
file 'config/deploy.rb', <<-CODE
require "bundler/capistrano"
require "nubis_rails_boilerplate"
NubisRailsBoilerplate::Capistrano.new(self, __FILE__, "#{app_name}")
CODE

rake 'db:migrate'
rake 'db:test:prepare'

git :init
git :add => "."
git :commit => %Q{ -m 'Initial commit' }
git remote: "add origin git@github.com:nubis/#{app_name}.git"

