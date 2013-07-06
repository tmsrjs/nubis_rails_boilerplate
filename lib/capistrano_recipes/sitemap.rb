namespace :sitemap do
  desc "Copy the sitemap from the latest release"
  task :symlink, roles: :app do
    run "if [[ -d #{previous_release}/public ]]; then cp -fr #{previous_release}/public/sitemap* #{release_path}/public/; fi"
  end
  after "deploy:finalize_update", "sitemap:symlink"
end
