# Place enable the module if required and restart apache
case node[:platform]
when "debian","ubuntu"

  Chef::Log.debug("Upgrading to php 7.0")

  execute "php_upgrade_latest" do
    user "root"
    command "apt-get purge 'php5*'"
    command "add-apt-repository ppa:ondrej/php"
    command "apt-get update"
    command "apt-get -y install php7.0 libapache2-mod-php7.0 php7.0-mysql mcrypt php7.0-mcrypt imagemagick php-imagick php7.0-curl php7.0-gd php7.0-intl php7.0-imap php7.0-xmlrpc  php7.0-pspell php7.0-recode php7.0-tidy php-apcu php7.0-json php7.0-mbstring php7.0-xml php7.0-bcmath php-redis php-yaml  php-gettext php-pear"
    command "apt-get autoremove"
    command "service apache2 restart"

    action :run
  end
end