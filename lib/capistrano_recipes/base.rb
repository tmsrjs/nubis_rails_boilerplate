def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} apt-get -y install libmysqlclient-dev mysql-client-5.5"
    run "#{sudo} apt-get -y install libpq-dev"
    run "#{sudo} apt-get -y install libxml2 libxml2-dev libxslt-dev imagemagick"
  end
end
