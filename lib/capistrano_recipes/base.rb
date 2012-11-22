def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} apt-get -y install libmysqlclient-dev mysql-client-5.5"
    run "#{sudo} apt-get -y install libxml2 libxml2-dev libxslt-dev imagemagick"
  end
  
  desc "Check if server was installed correctly"
  task :check_server do
    unless remote_file_exists?(deploy_to)
      puts "Your server is not setup yet. Please run: $ cap deploy:setup_server"
      exit 1
    end
  end
  before 'check:revision', 'deploy:check_server'
  
  task :setup_server do
    top.deploy.install
    top.deploy.setup
    top.deploy.cold
    top.deploy.migrations
  end
end
