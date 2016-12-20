# Place enable the module if required and restart apache
case node[:platform]
when "debian","ubuntu"

  Chef::Log.debug("Upgrading to php 7.0")

  execute "remove_php_5" do
    user "root"
    command "apt-get purge 'php5*'"
    action :run
    notifies :run, 'execute[add_ppa]', :immediately
  end

  execute "add_ppa" do
    user "root"
    command "add-apt-repository ppa:ondrej/php"
    action :nothing
  end
end