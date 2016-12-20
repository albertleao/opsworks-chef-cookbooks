# Place enable the module if required and restart apache
case node[:platform]
when "debian","ubuntu"

  Chef::Log.debug("Upgrading to php 7.0")

  execute "remove_php_5" do
    user "root"
    command "apt-get purge 'php5*' -y"
    action :run
    notifies :run, 'execute[add_ppa]', :immediately
  end

  execute "add_ppa" do
    user "root"
    command "add-apt-repository ppa:ondrej/php"
    notifies :run, 'execute[update_repositories]', :immediately
  end

  execute "update_repositories" do
    user "root"
    command "apt-get update"
    notifies :run, 'execute[install_latest_php]', :immediately
  end

  execute "install_latest_php" do
    user "root"
    command "apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql mcrypt php7.0-mcrypt imagemagick php-imagick php7.0-curl php7.0-gd php7.0-intl php7.0-imap php7.0-xmlrpc  php7.0-pspell php7.0-recode php7.0-tidy php-apcu php7.0-json php7.0-mbstring php7.0-xml php7.0-bcmath php-redis php-yaml php-gettext php-pear -y --force-yes"
    notifies :run, 'execute[cleanup_install]', :immediately
  end

  execute "cleanup_install" do
    user "root"
    command "apt-get autoremove -y --force-yes"
    notifies :run, 'execute[restart_server]', :immediately
  end

  execute "restart_server" do
    user "root"
    command "service apache2 restart"
    action :nothing
  end
end