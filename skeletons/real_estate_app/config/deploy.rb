require "bundler/capistrano"
require "nubis_rails_boilerplate"
NubisRailsBoilerplate::Capistrano.new(self, __FILE__, "#{app_name}")
