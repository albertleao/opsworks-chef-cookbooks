node[:deploy].each do |application, deploy|
  app_root = "#{deploy[:deploy_to]}/current"
  execute "chmod -R g+rw #{app_root}" do
  end
  execute "chmod -R 0777 #{app_root}/vendor" do
  end
  execute "chmod -R 0777 #{app_root}/storage" do
  end
  execute "chmod -R 0777 #{app_root}/storage/logs" do
  end
  execute "chmod -R 0777 #{app_root}/storage/sessions" do
  end
  execute "chmod -R 0777 #{app_root}/storage/files" do
  end
  execute "chmod -R 0777 #{app_root}/storage/cache" do
  end
end
