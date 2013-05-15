require 'active_support/core_ext'
module NubisRailsBoilerplate
  class Templates
    def self.expand_skeleton(skeleton, basefile)
      skeleton_path = File.absolute_path(File.expand_path("../../skeletons/#{skeleton}", basefile))
      `cp -r #{skeleton_path} #{get_app_name}`
      patch_module_name(skeleton, get_app_name)
      run_setup_tasks(get_app_name)
      puts "All done! Your app is ready to start customizing."
    end
  
    def self.patch_module_name(skeleton, app_name)
      puts "Patching #{skeleton} files for #{app_name}"
      %w(Rakefile config/application.rb config/environment.rb config/environments/development.rb
      config/environments/test.rb config/environments/production.rb config/initializers/secret_token.rb
      config/deploy.rb config/database.yml config/initializers/session_store.rb config/routes.rb config.ru).each do |filename|
        full_path = File.expand_path(filename, app_name)
        new_contents = File.read(full_path)
          .gsub(skeleton.camelize, app_name.camelize)
          .gsub(skeleton, app_name)
        File.write(full_path, new_contents)
      end
    end
    
    def self.run_setup_tasks(app_name)
      puts "Installing gems and configuring databases"
      Dir.chdir(app_name) do 
        `bundle install; rake db:create; rake db:migrate; rake db:test:prepare`
      end
    end
    
    def self.get_app_name
      if ARGV.size != 1
        puts "Call it like this: #{$0} app_name"
        exit 1
      end

      unless ARGV[0] =~ /^[a-z_]*$/
        puts "The app_name can only be lowercase letters and underscores"
        exit 1
      end

      return ARGV[0]
    end
  end
end
