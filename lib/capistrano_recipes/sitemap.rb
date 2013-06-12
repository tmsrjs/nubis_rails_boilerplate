namespace :sitemap do
  desc "Copy the sitemap from the latest release"
  task :symlink, roles: :app do
    run "cp -r #{previous_release}/public/sitemap* #{release_path}/public/"
  end
  after "deploy:finalize_update", "sitemap:symlink"
end
