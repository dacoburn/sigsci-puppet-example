# == Class sigsci::params
#
# This class is meant to be called from sigsci.
# It sets variables according to platform.
#
class sigsci::params {
  $webserver           = 'nginx'
  $module_version      = 'latest'
  $agent_version       = 'latest'
  $nginx_version       = 'latest'
  $manage_repo         = true
  $manage_agent        = true
  $manage_module       = true
  $manage_nginx        = false
  $nginx_release_type  = 'distro'
  $nginx_package       = 'sigsci-module-nginx'
  $apache_package      = 'sigsci-module-apache'
  $agent_package       = 'sigsci-agent'
  $service_name        = 'sigsci-agent'
  $nginx_config_file   = '/opt/sigsci/nginx/sigsci.conf'
  $config_file         = '/etc/sigsci/agent.conf'
  $user                = 'root'
  $group               = 'root'

  # If we are using managed_nginx, set webserver automatically
  if $manage_nginx {
    $webserver = 'nginx'
  }

}
