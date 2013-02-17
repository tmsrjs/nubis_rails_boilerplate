load 'deploy'
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each do |plugin|
  load(plugin)
end
load 'config/deploy'
