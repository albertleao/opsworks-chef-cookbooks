node[:deploy].each do |application, deploy|
  app_root = "#{deploy[:deploy_to]}/current"
  execute "chmod -R g+rw #{app_root}/vendor" do
  end
end