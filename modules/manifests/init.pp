# SignalSciences Puppet Module
#
# Copyright (C) 2015 Signal Sciences Corp.
#
# All rights reserved - Do Not Redistribute
#
class sigsci (
  $agent_package      = $::sigsci::params::agent_package,
  $service_name       = $::sigsci::params::service_name,
  $manage_agent       = $::sigsci::params::manage_agent,
  $manage_module      = $::sigsci::params::manage_module,
  $manage_repo        = $::sigsci::params::manage_repo,
  $manage_nginx       = $::sigsci::params::manage_nginx,
  $nginx_release_type = $::sigsci::params::nginx_release_type,
  $agent_version      = $::sigsci::params::agent_version,
  $module_version     = $::sigsci::params::module_version,
  $webserver          = $::sigsci::params::webserver,
  $config_file        = $::sigsci::params::config_file,
  $user               = $::sigsci::params::user,
  $group              = $::sigsci::params::group,
  $settings           = {
                          rpc_address      => 'unix:/var/run/sigsci.sock',
                          client_ip_header => 'X-Forwarded-For',
                        },
  $accesskeyid,
  $secretaccesskey,
) inherits ::sigsci::params {
  if $manage_repo {
    include ::sigsci::repository
  }
  if $manage_agent {
    include ::sigsci::install::agent
    include ::sigsci::config::agent
  }
  if $manage_nginx {
    if !$manage_repo {
      fail("Please enable manage_repo to use sigsci provided nginx")
    }
    include ::sigsci::install::nginx
  }
  if $manage_module {
    include ::sigsci::install::module
    case $sigsci::webserver {
      'nginx':  { include ::sigsci::config::nginx }
      'apache':  { include ::sigsci::config::apache }
      default:  { fail("webserver ${sigsci::webserver} is not supported") }
    }
  }

  class { '::sigsci::service': } -> Class['::sigsci']

}
