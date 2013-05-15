module NubisRailsBoilerplate
  class Capistrano
    attr_accessor :cap, :cap_path, :app_name
    def initialize(cap, cap_path, app_name)
      self.cap = cap
      self.cap_path = cap_path
      self.app_name = app_name

      cap.set :host_app_path, cap_path
      cap.set :repository, "git@github.com:nubis/#{app_name}.git"
      load_configs
      check_git_repo
      load_modules
      load_permission

      cap.set :user, "ubuntu"
      cap.set :application, app_name
      cap.set :deploy_to, "/home/ubuntu/apps/#{app_name}"
      cap.set :deploy_via, :remote_cache
      cap.set :use_sudo, false
      cap.set :scm, "git"
      cap.set :branch, "master"
      cap.set :keep_releases, 2
      cap.default_run_options[:pty] = true
      cap.ssh_options[:forward_agent] = true
      cap.after "deploy", "deploy:cleanup" # keep only the last 5 releases
    end
    
    def check_git_repo
      output = `git pull origin master 2>&1`
      unless $?.success?
        puts "You need to be able to access #{cap.repository} before you deploy."
        puts "Make sure that it exists and you can access it before you continue."
        puts "The error was:"

        puts output
        exit 1
      end
    end
    
    def load_modules
      path = File.expand_path('../capistrano_recipes', __FILE__)
      modules = Dir["#{path}/*.rb"].collect{|f| File.basename(f)}
      modules.sort.each do |m|
        puts "Loading cap module #{m}"
        cap.load File.join(path, m)
      end
    end
    
    def load_permission
      permission_path = File.expand_path('../../config/permission.pem', cap_path)
      unless File.file?(permission_path)
        puts "You don't have permission to push to the server"
        puts "I could not find a file named #{permission_path}"
        puts "Please request one and try again"
        exit 1
      end
      cap.ssh_options[:keys] = permission_path
    end
    
    def load_configs
      configs_path = File.expand_path('../../config/deploy.yml', cap_path)
      unless File.file?(configs_path)
        puts "You don't have the required configuration options to push to production"
        puts "I could not find a file named #{configs_path}"
        puts "Please request one and try again"
        exit 1
      end
      configs = YAML.load_file(configs_path)
      unless configs.values.all?
        puts "You need to provide your configuration options before you can push."
        puts "Setup your server and database and input your data in: #{configs_path}"
        exit 1
      end
      configs.each do |key, value|
        cap.set :configs, configs
      end
      cap.server configs['site_url'], :web, :app, :db, primary: true
    end
  end
end
