namespace :deploy_configs do
  desc "Generate the deploy.yml configuration file."
  task :setup, roles: :app do
    upload File.expand_path("../../config/deploy.yml", host_app_path), "#{release_path}/config/deploy.yml"
  end
  after "deploy:finalize_update", "deploy_configs:setup"
end
