#
# Taken from:
# http://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted.walkthrough.photoapp.3.html
#
node[:deploy].each do |application, deploy|
  script "migrate_phinx" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    sh phinx.sh migrate -e production
    EOH
    only_if { ::File.exists?("#{deploy[:deploy_to]}/current/phinx.sh") }
  end
end 
